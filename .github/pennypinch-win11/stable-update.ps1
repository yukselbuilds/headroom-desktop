function Open-UpdateSocket {
    $target = Wait-For 70 {
        try {
            @(Invoke-RestMethod 'http://127.0.0.1:49257/json/list' -TimeoutSec 2) |
                Where-Object { $_.type -ceq 'page' -and $_.url -cmatch '^https?://tauri\.localhost/' } |
                Select-Object -First 1
        } catch [System.Net.WebException] {}
    }
    if (!$target -or $target.webSocketDebuggerUrl -cnotmatch '^ws://127\.0\.0\.1:49257/devtools/page/[A-Za-z0-9_-]+$') {
        throw 'update_debug_target_missing'
    }
    $connection = [Net.WebSockets.ClientWebSocket]::new()
    $stop = [Threading.CancellationTokenSource]::new(8000)
    try {
        [void]$connection.ConnectAsync([uri]$target.webSocketDebuggerUrl, $stop.Token).GetAwaiter().GetResult()
    } catch {
        $connection.Dispose()
        throw
    } finally { $stop.Dispose() }
    $script:cdpSequence = 0
    return $connection
}

function Update-Snapshot {
    return Invoke-Page "window.__TAURI_INTERNALS__.invoke('manage_updates',{request:{request_id:crypto.randomUUID(),action:{kind:'snapshot'}}})"
}

function Click-UpdateButton([string]$label, [string]$scopeCss = 'body') {
    $encoded = ConvertTo-Json -InputObject $label -Compress
    $container = ConvertTo-Json -InputObject $scopeCss -Compress
    return Invoke-Page "(()=>{const root=document.querySelector($container); if(!root)return false; const button=[...root.querySelectorAll('button')].find(b=>!b.disabled&&(b.textContent.trim()===$encoded||b.getAttribute('aria-label')===$encoded));if(!button)return false;setTimeout(()=>button.click(),150);return true})()"
}

function Require-RegisteredVersion([string]$version, [string]$digest) {
    $registration = 'HKCU:\Software\Microsoft\Windows\CurrentVersion\Uninstall\Headroom'
    $item = Get-ItemProperty -LiteralPath $registration
    if ($item.DisplayVersion -cne $version -or $item.InstallLocation.Trim('"') -ine $destination -or
        (Get-FileHash -LiteralPath (Join-Path $destination 'headroom-desktop.exe')).Hash -ine $digest) {
        throw 'update_registration_or_digest_mismatch'
    }
}

function Test-StableUpdate {
    $candidate = Get-Content -LiteralPath (Join-Path $PSScriptRoot 'candidate.json') -Raw | ConvertFrom-Json
    $predecessor = Join-Path $PSScriptRoot 'predecessor.exe'
    $exe = Join-Path $destination 'headroom-desktop.exe'
    $preferences = Join-Path $profile 'preferences/preferences.json'
    $section = 'section[aria-labelledby=updates-title]'
    $result.update = [ordered]@{ passed = $false; versions = @(); checks = [ordered]@{} }
    $result.phase = 'update_preflight'
    if ((Get-FileHash -LiteralPath $predecessor).Hash -ine $candidate.predecessor_sha256 -or
        $candidate.predecessor_version -cne '0.1.0' -or $candidate.version -cne '0.1.1') {
        throw 'unexpected_predecessor'
    }
    Require-RegisteredVersion '0.1.1' $candidate.executable_sha256
    Copy-Item -LiteralPath $predecessor -Destination $exe -Force
    $registration = 'HKCU:\Software\Microsoft\Windows\CurrentVersion\Uninstall\Headroom'
    Set-ItemProperty -LiteralPath $registration -Name DisplayVersion -Value '0.1.0'
    Require-RegisteredVersion '0.1.0' $candidate.predecessor_sha256
    $result.update.versions += '0.1.0'
    $env:WEBVIEW2_ADDITIONAL_BROWSER_ARGUMENTS = '--remote-debugging-port=49257 --remote-debugging-address=127.0.0.1'
    $socket = $null
    try {
        $app = Start-Process -FilePath $exe -WorkingDirectory $destination -WindowStyle Normal -PassThru
        $socket = Open-UpdateSocket
        if (!(Wait-For 25 { (Update-Snapshot).installed_version -ceq '0.1.0' })) { throw 'predecessor_window_missing' }
        if (!(Wait-For 25 { (Click-UpdateButton 'Settings') -or (Click-UpdateButton 'Ayarlar') })) { throw 'settings_button_missing' }
        if (!(Wait-For 25 { Invoke-Page @'
(()=>{const s=[...document.querySelectorAll('select')].find(x=>[...x.options].some(o=>o.value==='tr')&&[...x.options].some(o=>o.value==='en'));if(!s||s.disabled)return false;if(s.value!=='en'){s.value='en';s.dispatchEvent(new Event('change',{bubbles:true}))}return true})()
'@
        }) -or !(Wait-For 25 {
            (Invoke-Page "window.__TAURI_INTERNALS__.invoke('get_preferences',{requestId:crypto.randomUUID()}).then(v=>v.preferences.language)") -ceq 'en'
        })) { throw 'update_language_not_saved' }
        $prefsControl = Wait-For 25 { Invoke-Page @'
(()=>{const s=[...document.querySelectorAll('select')].find(x=>[...x.options].some(o=>o.value==='dark')&&[...x.options].some(o=>o.value==='light'));if(!s)return false;s.value='dark';s.dispatchEvent(new Event('change',{bubbles:true}));return true})()
'@
        }
        if (!$prefsControl -or !(Wait-For 25 {
            (Invoke-Page "window.__TAURI_INTERNALS__.invoke('get_preferences',{requestId:crypto.randomUUID()}).then(v=>v.preferences.theme)") -ceq 'dark'
        })) { throw 'update_preferences_not_saved' }
        $preferenceHash = (Get-FileHash -LiteralPath $preferences).Hash
        $result.phase = 'signed_update_check'
        if (!(Wait-For 25 { Click-UpdateButton 'Check for updates' $section })) { throw 'stable_check_button_missing' }
        if (!(Wait-For 50 {
            try { $info = Update-Snapshot; $info.status -ceq 'available' -and $info.channel -ceq 'stable' -and $info.candidate.version -ceq '0.1.1' }
            catch { $false }
        })) { throw 'signed_stable_release_unavailable' }
        $result.update.checks.signed_production_manifest = $true
        $result.phase = 'download_update'
        if (!(Wait-For 25 { Click-UpdateButton 'Download and verify' $section })) { throw 'update_download_button_missing' }
        $downloadTimer = [Diagnostics.Stopwatch]::StartNew()
        # The updater allows 300 seconds for download and 90 seconds for extraction.
        $download = Wait-For 420 { Invoke-Page @'
(() => {
  const root = document.querySelector('section[aria-labelledby=updates-title]');
  if (!root) return null;
  const alert = root.querySelector('[role=alert]')?.textContent?.trim();
  const errors = {
    'The trusted update source could not be reached.': 'source_failed',
    'The package could not be written to the app directory.': 'storage_failed',
    'The download was interrupted. You can retry.': 'download_failed',
    'The package did not match the signed release.': 'integrity_failed',
    'The update package could not be prepared. Check available disk space and retry.': 'preparation_failed',
    'The update response could not be validated.': 'invalid_response',
    'The update status could not be read.': 'request_failed',
    'The selected update changed. Check again.': 'candidate_changed',
    'Another update operation is running. Refresh the status.': 'busy',
  };
  if (alert) return Object.hasOwn(errors, alert) ? errors[alert] : 'other_alert';
  const status = root.querySelector('[role=status]')?.textContent?.trim();
  if (status === 'Package verified and ready for this session.') return 'ready';
  if (status === 'Package verified. Waiting for the engine to stop.') return 'waiting_for_engine';
  return null;
})()
'@
        }
        $result.update.download_seconds = [math]::Round($downloadTimer.Elapsed.TotalSeconds, 3)
        $result.update.download_result = if ($download) { $download } else { 'timeout' }
        if ($download -cne 'ready' -or !(Update-Snapshot).can_apply) { throw 'package_not_verified' }
        $result.update.checks.signed_package_verified = $true
        $result.phase = 'install_update'
        if (!(Wait-For 25 { Click-UpdateButton 'Update and restart' $section }) -or
            !(Wait-For 25 { Click-UpdateButton 'Continue' '[role=group][aria-label="Update and restart"]' })) { throw 'update_confirmation_missing' }
        if (!$app.WaitForExit(35000)) { throw 'app_restart_timeout' }
        $socket.Dispose()
        $socket = Open-UpdateSocket
        if (!(Wait-For 35 { try { (Update-Snapshot).installed_version -ceq '0.1.1' } catch { $false } })) { throw 'new_app_window_missing' }
        Require-RegisteredVersion '0.1.1' $candidate.executable_sha256
        if ((Get-FileHash -LiteralPath $preferences).Hash -cne $preferenceHash) { throw 'update_preferences_changed' }
        $result.update.versions += '0.1.1'
        $result.update.checks.updated_app_reopened = $true
        $result.phase = 'restore_update'
        $updatedApp = Get-Process -Name 'headroom-desktop' | Where-Object { $_.Path -ieq $exe } | Select-Object -First 1
        if (!$updatedApp -or !(Wait-For 25 { Click-UpdateButton 'Settings' }) -or
            !(Wait-For 35 { Click-UpdateButton 'Restore previous version' $section }) -or
            !(Wait-For 25 { Click-UpdateButton 'Continue' '[role=group][aria-label="Restore previous version"]' })) {
            throw 'rollback_confirmation_missing'
        }
        if (!$updatedApp.WaitForExit(35000)) { throw 'rollback_restart_timeout' }
        $socket.Dispose()
        $socket = Open-UpdateSocket
        if (!(Wait-For 35 { try { (Update-Snapshot).installed_version -ceq '0.1.0' } catch { $false } })) { throw 'restored_app_missing' }
        Require-RegisteredVersion '0.1.0' $candidate.predecessor_sha256
        if ((Get-FileHash -LiteralPath $preferences).Hash -cne $preferenceHash) { throw 'rollback_preferences_changed' }
        $result.update.versions += '0.1.0'
        $result.update.checks.original_exe_and_preferences_restored = $true
        $restored = Get-Process -Name 'headroom-desktop' | Where-Object { $_.Path -ieq $exe } | Select-Object -First 1
        $confirmed = Invoke-Page "window.__TAURI_INTERNALS__.invoke('request_desktop_exit',{requestId:crypto.randomUUID()}).then(v=>{if(!v.exit_token)return false;setTimeout(()=>window.__TAURI_INTERNALS__.invoke('confirm_desktop_exit',{requestId:crypto.randomUUID(),exitToken:v.exit_token}),300);return true})"
        if (!$confirmed -or !$restored -or !$restored.WaitForExit(30000)) { throw 'restored_app_exit_failed' }
        $result.update.checks.restored_app_closed = $true
        $result.update.passed = $true
    } finally {
        if ($socket) { $socket.Dispose() }
        Remove-Item Env:\WEBVIEW2_ADDITIONAL_BROWSER_ARGUMENTS -ErrorAction SilentlyContinue
    }
}
