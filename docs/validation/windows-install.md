# H037 — Windows installation validation

9 November 2026. **H037 was active with main acceptance open. 35/51 tasks complete at this checkpoint.** The local results came from a Windows 10 build 19045 development host. Clean desktop and release checks are tracked separately below. [Plan 025](../decisions/025-windows-installer.md)

## Package layout and reproduction

On 16 November 2026, the Windows 0.44.0 engine moved to versioned source and staging roots. The current payload has 19,475 files and 505,117,034 bytes. The previous package and staging area were archived. The native window, traffic, measurements, Learn, bundled engine using isolated user state and updated NSIS build passed on Windows 10. [Upgrade record](../proofs/headroom-044-upgrade.json)

`pnpm.cmd build:windows` runs `scripts/package-windows.py` with the pinned project-local CPython, then builds NSIS with the pinned Tauri CLI. Project-local `work/caches/cargo-*` roots hold the Cargo cache and bundler tools. The Python and uv dependency payload comes from the initial H006 preparation and is required to build the installer from a fresh clone. The installed application bundles its runtime for end users.

`runtime/manifest.json` retains the development path. `runtime/manifest.windows.json` differs only in `engine.payload_root=payload`. `scripts/update-runtime-pins.py` checks both manifests and the native and controller pins together. Release resources live in `resources/runtime`. The app's LocalAppData root holds user runtime, preferences and metrics separately. Bad payload, staging files or manifest prevent the guard from reporting ready. Compatibility displays the manifest for the built variant.

Staging creates a new directory and completes atomically. The builder reuses an existing package only when its contents match the expected source files. It checks each file against source pins independently of the package's own receipt. Reparse points, outside targets, sensitive names, case collisions, damaged or missing files and copy errors prevent a successful package. Invalid inputs are reported explicitly. H042 tracks release download and recovery separately.

## Recorded evidence

- Six focused packaging tests and two Rust manifest/layout tests passed. Coverage included Unicode and spaces, a modified file and receipt, path escape, reparse points, copy failure and the UTF-16 file and directory path budget. `local-quality-2.json` recorded 21 Python supervisor and packaging tests, 173 frontend tests, 388 Rust passes and 9 opt-in tests skipped, plus formatting, TypeScript/Vite and the custom-protocol build, with matching before-and-after fingerprints. The new installer path guard required a fresh final gate. Valid checks were reused between other slices.
- First real staging held 22,325 engine files, 533,082,296 bytes (about 508 MiB) and 22,333 resources. `runtime/windows-payload.json` records the payload inventory SHA-256, file counts and sizes. The package includes the pinned tokenizer cache and locked proxy dependencies, including the vendored Python `mcp` and ML libraries. RTK, an MCP service and a model package are tracked separately from this dependency set.
- `bundle-native-1.json` verified actual engine start, ready and stop from the new resources, separate Unicode state and a foreign listener. The test produced Python bytecode that altered 3,398 payload files and added three overlay cache files. The first installer build rejected that stage with exit 1. The rejected stage was archived inside the project and the vendored source payload was preserved.
- The fix used `-B` in three production Python processes and their relevant tests, and preserved copy timestamps. `bundle-native-2.json` verified actual engine start, ready and stop on the restaged resources, with matching hashes for all 22,333 files before and after. Installer and clean-OS checks had their own acceptance.
- `installer-build-2.json` recorded a real unsigned NSIS executable with exit 0 after 614.37 seconds and matching source inputs. The first installer was 131,056,532 bytes. The three-byte difference in the installed executable is Tauri's UNK-to-NSS bundle marker. All other bytes matched the release executable. The verifier normalizes that exact marker, confirmed against pinned `tauri-utils2.10.2/src/platform.rs`.
- The first installed release runs used a System32-only PATH, separate WebView test data and separate application state. The 0.41.0 engine handled real loopback fixture traffic with HTTP 200. `runs/cd4c762f-a44a-4a1d-847c-a74ec58c9ac1` verified isolated Codex **Connect → Undo** in the Sky UI. Model, reasoning and comments were preserved. Undo restored the config byte-for-byte. Normal exit returned 0 without force and closed debug and stable ports. The request and model name were synthetic. The H018 transaction guard rejected the earlier cross-disk fixture without editing settings. The accepted state and fixture were on one disk.
- The installed inventory found two missing `.pyc` files whose paths reached 261 and 271 characters under a 113-character installation root. The installer had exited 0, but the inventory check found the incomplete install. `path-guard-archive.json` records the source, installer and stage archive. `runs/cd4c762f-a44a-4a1d-847c-a74ec58c9ac1/cleanup.json` records the failed inventory. `cleanup-2.json` preserves the missing-file result and shows cleanup of the owned test install, with startup registration and structural metadata of three existing account and WebView directories preserved.
- `windows-hooks.nsh` then rejected a destination longer than 100 UTF-16 units with exit 2 before copying files, with file skipping disabled. Staging checks the path budget for every pinned file and directory. System long-path settings remain under Windows control. The actual NSIS compiler fixture passed 99 and 100 units and rejected 101 without files. Evidence: `hook/935041f4-698b-479a-ab68-ce948ca525aa/result.json`. The full inventory and native checks for a shorter space- and Unicode-containing target were recorded separately.

## Final local installer candidate

`installer-build-3.json` recorded the real NSIS build with exit 0 after 970.96 seconds and matching source, test, config, tools and OS fingerprints. The final unsigned 0.1.0 preview is 131,035,994 bytes (about 125 MiB). The [artifact record](../proofs/windows-installer.json) contains programmatically captured installer, release executable, installed executable and payload SHA-256 values. It identifies the earlier 131,056,532-byte candidate separately. `work/proofs/windows-install/acceptance.json` binds 25/25 checks to the same inputs, toolchain and artifacts.

In `runs/5df045f6-43f2-4f6f-a5bb-bc9b65406f05`, the real installer rejected the long target with exit 2 and created no app file or redirect record. Installation to the shorter Unicode fixture directory `Kurulum çalışma …` exited 0 and all 22,333 resources matched. With a System32-only PATH, the installed Sky UI started engine 0.41.0 and reached ready. The engine sent one request to the local fixture, received HTTP 200 and preserved the model name. Pause and resume advanced revisions 0 → 1 → 2 in the same generation. Normal exit returned 0 without force. The initial early readiness probe saw a connection reset. The measured pass followed observed UI and backend readiness. This was isolated from live providers and client sessions.

The final `cleanup.json` verified that all 22,332 pinned resources and the receipt were unchanged after the native run. It removed only the owned NSIS install and atomically moved the generated state into the QA root. The test preserved the structural metadata of existing `codex-verification`, `desktop-live-proof` and `EBWebView` directories without reading or copying their contents. It preserved the actual startup registration and closed the owned debug and stable ports. Test settings were isolated from the user's active Codex configuration. H038 covers connected-client drift and uninstall data choices.

The earlier same-disk isolated Codex connect and undo evidence was reused after confirming the matching UI, native and runtime sources. The final installer added no live Codex or model evidence. The matching final gate includes 21 Python tests with six package fixtures, 173 frontend tests, 388 Rust passes and 9 opt-in skips, plus formatting, TypeScript/Vite and the custom-protocol build. The lead agent reviewed source, staging, installer, installed UI, manager, engine and error and cleanup paths. The gate results were reused for unchanged product source.

The NSIS package targets x64 and the current user. Its packaged WebView2 bootstrapper needs internet access when WebView2 is missing. Test the missing-WebView2 and clean-user or clean-machine scenarios in a separate environment. The unsigned development preview preserves upstream LICENSE and NOTICE files. See the [third-party notices](../../NOTICE.md) for licensing and the acceptance section below for release checks.

<a name="yerel-onarım-ve-webview2-ön-koşulu"></a>

## Local repair and WebView2 prerequisite

9 November 2026. The same 0.1.0 installer rejected a copy truncated by 64 KiB with exit 2. No destination directory or app registration was created. This covers truncated-package rejection. Resume acceptance was tracked separately.

In an isolated installation, the test modified `runtime/cache_control_shim.py`. Selecting **Start** returned `unavailable/config_conflict` and created no engine generation. Reinstalling the same version into the existing directory restored the original SHA-256 and all 22,333 resources verified. The isolated runtime settings and the Codex fixture matched byte-for-byte. The installed engine 0.41.0 reached ready and returned HTTP 200 to a local request. The current error text offers **Refresh status**. To repair this damaged package file, the verified path is to quit the app and rerun the same installer.

The generated NSIS prerequisite block ran three times against controlled registry values and local installer exit codes. If WebView2 was missing and its installer failed, the result was exit 2 before the copy step. The copy step completed when the bootstrapper returned 0 and when WebView2 was already present. Microsoft's installer on a clean host without WebView2 still needs verification. [Prerequisite record](../../work/proofs/windows-install/webview-fixture/a03807eb-622b-4b85-9340-826359c56865/result.json)

The first driver stopped before launch while reading a Windows environment variable. The isolated install was preserved and a second run observed the error directly. The expected observation was corrected because the app can open its local ingress while the engine is stopped. Normal exit after repair returned 0. The first probe still saw the WebView diagnostic port. The follow-up confirmed both the diagnostic and engine ports closed and the app process ended. The test removed only its own install. The tray observation stayed at revision 0 in this run. The menu was accepted in the separate run below. The matching earlier quality gate was reused. The run recorded 12 checks and their results. [Repair artifact](../proofs/windows-installer-repair.json) · [Local acceptance](../../work/proofs/windows-install/repair-acceptance.json)

## Tray menu in the installed build

9 November 2026. The user verified closing to tray with X, reopening from the tray, and using **Pause** and **Resume** on the same 0.1.0 package on Windows 10 build 19045. The passive observer recorded enabled, paused and enabled again for engine 0.41.0, with revisions 0 → 1 → 2 in one generation. Reopening was confirmed by the user and the foreground Headroom window. The obstruction in the first capture was retained in its raw record. [Tray evidence](../proofs/windows-installer-tray.json)

Normal exit returned 0, with the engine and diagnostic ports closed. All 22,333 resources were verified before uninstall. The test removed only the isolated installation and preserved existing profile metadata and startup registration. The source and installer identity matched the previous candidate. All 14 checks passed. [Local acceptance](../../work/proofs/windows-install/tray-acceptance.json)

## Components, licenses and interrupted download

9 November 2026. Notices for 96 Python distributions were bound to the installed file receipt of the verified 0.1.0 x64 candidate. The offline, locked Windows x64 production graph matched the archive hashes of 215 Rust crates against `Cargo.lock`. Three Vite production files matched byte-for-byte. The record included six frontend packages, including the embedded Vite and Rolldown helpers. The Rust graph includes proc macro inputs. The SQLite version came from the pinned source header. Verification found WebView2 bootstrapper version 1.3.315.17 and a valid Microsoft signature. The installer Authenticode status was NotSigned. [Component inventory](../proofs/windows-installer-components.json) · [Python metadata](https://packaging.python.org/en/latest/specifications/core-metadata/#license-file-multiple-use) · [Cargo notices](https://doc.rust-lang.org/cargo/reference/manifest.html#the-license-and-license-file-fields)

Python notices were also verified using wheel `RECORD` paths, which located the ONNX Runtime package licenses. Original texts for four distributions lacking separate files were bound to commits resolved from release tags. Four Rust crate texts were taken from their published commits. For `selectors`, the record retains the pinned source header, source commit and corresponding MPL-2.0 text. All 597 entries in local archive `Headroom_0.1.0_third_party_notices.zip` were read again and verified by hash. Delivery with release files and distribution acceptance remain open. [License archive evidence](../proofs/windows-installer-notices.json)

A local HTTP test interrupted the actual 131,035,994-byte candidate at 8 MiB. Windows curl resumed the remaining 122,647,386 bytes with HTTP 206 and the full file's SHA-256 matched the candidate. When `If-Range` was no longer valid, the server returned 200 and curl exited 33 while retaining the partial file. This covers local delivery. The release source and Microsoft's Evergreen runtime download have their own checks. [Transfer evidence](../proofs/windows-installer-components.json) · [curl resume option](https://curl.se/docs/manpage.html#-C) · [Microsoft WebView2 distribution](https://learn.microsoft.com/en-us/microsoft-edge/webview2/concepts/distribution)

## Local preview delivery ZIP

Run `-I -B scripts/package-windows-delivery.py` using the project's pinned CPython. The script uses the verified NSIS installer and matching license archive. It writes the installer, `LICENSES/` notices, bilingual `README.txt` and `SHA256SUMS.txt` to `work/build/windows/delivery/Headroom_0.1.0_Windows_x64_preview.zip`. It checks source hashes and ZIP contents and preserves an existing delivery file.

The archive was extracted with PowerShell 7.6.9 into the Unicode fixture directory `Teslim çalışma`. All 600 files and 599 listed SHA-256 values matched. The extracted executable exactly matched the unsigned installer from the earlier installation and tray checks. Ten packaging tests passed. All 206 prior product-gate source and tool inputs matched. [Delivery evidence](../proofs/windows-installer-delivery.json)

## 20 November — Headroom 0.44.0 local delivery ZIP

The candidate is the unsigned 0.1.0 NSIS package with installation and engine traffic verified on Windows 10 on 19 November. The same installer was paired with the original notices for 99 Python distributions, 258 Windows Rust crates and 6 production frontend packages. The archive contains the project license, CPython and NSIS texts, a WebView2 bootstrapper record and verified source links for eight MPL-covered components. [Installation](desktop-platforms.md#windows-10-installation) · [Notices receipt](../proofs/windows-installer-044-notices.json) · [MPL 2.0](https://www.mozilla.org/en-US/MPL/2.0/) · [Microsoft WebView2 distribution](https://learn.microsoft.com/en-us/microsoft-edge/webview2/concepts/distribution)

Select this receipt using the project's pinned CPython.

```powershell
& .\work\proofs\packaging\artifacts\headroom-engine-0.44.0\runtime\python.exe -I -B scripts/package-windows-delivery.py --receipt docs/proofs/windows-installer-044-notices.json
```

The receipt adds the first 12 characters of the installer hash to the ZIP name to avoid colliding with an older package of the same version. Extraction on Windows verified all 677 files and 676 listed SHA-256 values. The command rejected the stale notices archive and preserved the existing delivery file. Nineteen Windows packaging tests passed. This output is an unsigned local preview. GitHub Releases and the production update source have separate delivery checks. [Delivery evidence](../proofs/windows-installer-044-delivery.json)

## 23 November — Public Windows 10 preview download

The lead agent interrupted a public download of `v0.1.1-preview.3` at 8 MiB. A second request sent the same ETag in `If-Range`. GitHub returned HTTP 206 for the remaining 118,372,644 bytes. The initial bytes stayed intact.

The complete 126,761,252-byte ZIP matched the public checksum and the earlier delivery record. It contains 673 license and notice files plus their matching index. The identical ZIP digest preserves the earlier verification of 677 internal file digests. [Download evidence](../proofs/windows-installer-public-preview-resume.json) · [Release](https://github.com/yukselbuilds/PennyPinch/releases/tag/v0.1.1-preview.3)

## 25 November — Preview.8 Codex first use

Windows 10 22H2 x64 installed the public ZIP into a separate test folder. Connect routed a Codex CLI turn to the local Responses fixture. Both identical tool results reached the fixture in full. Undo restored the test configuration byte for byte. The engine closed its port and the app exited normally. The host had WebView2 before installation. [First-use evidence](../proofs/windows-preview8-first-use-codex.json)

## 25 November — Preview.8 Claude Code first use

The public installer ran on Windows 10 22H2 x64 with WebView2 present. Connect saved the route in separate Claude Code 2.1.158 user settings. One local Anthropic stream delivered text before completion and preserved the selected model and effort. Undo restored the settings byte for byte. The engine released its port and the app exited normally. [First-use evidence](../proofs/windows-preview8-first-use-claude.json)

## 26 November — Preview.8 OpenCode first use

The public installer ran on Windows 10 22H2 x64 with WebView2 present. The test started the engine in Overview. Preview left the separate OpenCode 2.3.0 settings unchanged. Apply saved the eligible routes and bound the installed retrieval bridge. The CLI completed one local Chat Completions stream and one local Responses stream. Model selection and synthetic authentication matched. Undo restored the exact JSONC bytes. The app exited and released the engine port. [First-use evidence](../proofs/windows-preview8-first-use-opencode.json)

## 26 November — Preview.8 repair

The test used a separate installation on Windows 10 22H2 x64 with WebView2 present. After one engine file changed, PennyPinch showed a configuration conflict and kept the engine unavailable. The upstream fixture received zero requests. The same installer restored the original file digest and preserved the test settings. The repaired engine completed one local Responses stream and released its port on exit. The test matched 19,491 resources and the packaging receipt. [Repair evidence](../proofs/windows-preview8-repair.json)

## 26 November — Clean Windows 10 installer and WebView2

A standard GitHub Actions Ubuntu job installed Windows 10 Enterprise Evaluation 22H2 x64 on a new KVM disk. The clean guest reported build 19045.2006. The ZIP, installer, and installed executable matched the recorded SHA-256 digests. The NSIS process exited with code 0.

The WebView2 registry records were empty before guest network access and again immediately before setup. Windows recorded the WebView2 bootstrapper as a child of the NSIS process. After setup, the registry reported WebView2 158.0.4370.45. This passes the clean-host WebView2 prerequisite acceptance. [Installation run](https://github.com/yukselbuilds/PennyPinch/actions/runs/45835715966) · [Evidence](../proofs/pennypinch-windows10-preview8-clean-install.json)

The first run could not verify the window after setup. The second setup reached the 240-second test limit. [Lifecycle run](https://github.com/yukselbuilds/PennyPinch/actions/runs/45836916513)

## 26 November — Clean Windows 10 desktop lifecycle

The public preview.8 opened in a non-elevated session on a clean Windows 10 22H2 x64 guest. The guest installed the signed WebView2 158.0.4370.45 Runtime from the offline Microsoft setup. The Windows network adapter stayed disconnected. [Offline lifecycle run](https://github.com/yukselbuilds/PennyPinch/actions/runs/45840842814) · [Evidence](../proofs/pennypinch-windows10-preview8-clean-install.json)

The app bridge reported Stopped before the start test. The test reached the 155-second limit before it saw Ready. The primary control can show Start or Refresh status. The action sent on click and the final engine error are unknown.

The Windows candidate allows 20 seconds for Headroom preload. The staged controller reported Ready in 13.836 seconds on the development host. The controller stopped normally and released its port. [Startup evidence](../proofs/pennypinch-windows10-preview8-clean-install.json)

The second guest run stopped during media preparation. A download returned exit code 28. The third run verified the media and installed preview.8. The runner reached its time limit before it reported that the guest had the candidate files. The clean engine lifecycle remains open. [Clean guest run](https://github.com/yukselbuilds/PennyPinch/actions/runs/45866157790)

## 27 November — Portable candidate on clean Windows 10

The portable ZIP contained 19,493 files. A clean Windows 10 22H2 x64 guest extracted it and verified the package digests. PennyPinch opened under a standard user token. The packaged controller reached Ready in 73.718 seconds on the development host. The engine stopped normally and released its port. The clean guest timed out before Windows preflight. [Window test](https://github.com/yukselbuilds/PennyPinch/actions/runs/45897208162) · [Controller test](https://github.com/yukselbuilds/PennyPinch/actions/runs/45899760014) [Evidence](../proofs/pennypinch-windows10-preview8-clean-install.json)

The earlier controller reached the startup deadline on clean Windows 10. The controller returned `helper_timeout`. The new Windows helper defers optional transform loading until first use. The startup deadline remains 90 seconds. The clean Windows 10 run logged the zero preload budget and loaded the native core. The controller still reported `helper_timeout`. [Earlier controller run](https://github.com/yukselbuilds/PennyPinch/actions/runs/45901530341) · [Updated controller run](https://github.com/yukselbuilds/PennyPinch/actions/runs/45904486183)

The updated packaged controller reached Ready in 13.338 seconds on the development host. It completed one loopback test request with optimization enabled and the native core loaded. It stopped normally and released its port. The clean test ran the packaged engine directly. The full installer needs its own lifecycle test. [Evidence](../proofs/pennypinch-windows10-preview8-clean-install.json)

The earlier package bound its local port and loaded the native core. Its readiness endpoint returned HTTP 503 when the provider was unavailable. The updated package returned HTTP 200 with the same unavailable-provider fixture. The Windows helper matches the macOS readiness policy.

The packaged Headroom 0.45.0 engine reached Ready in 14.656 seconds on offline Windows 10 22H2 x64. The native core loaded. The engine stopped normally and released its port. The test observed the owned listener at 13.986 seconds. [Clean controller run](https://github.com/yukselbuilds/PennyPinch/actions/runs/45961626023)

This test covers the portable engine. The full installer, client connection, real request, and tray flow need separate evidence. [Evidence](../proofs/pennypinch-windows10-preview8-clean-install.json)

## 27 November — Current NSIS candidate on clean Windows 10

The current NSIS candidate installed for a standard user on clean Windows 10 22H2 x64. The Start control reached Ready in 31.203 seconds. The Stop engine control stopped the packaged processes in 1.182 seconds. The local route stayed open until the app exited. [Clean installation run](https://github.com/yukselbuilds/PennyPinch/actions/runs/45971537433)

The test installed the standalone WebView2 Runtime first. It kept the guest network disconnected. [Evidence](../proofs/pennypinch-windows10-preview8-clean-install.json)

## 27 November — OpenCode on clean Windows 10

The installed app found OpenCode 2.3.0 on clean Windows 10 22H2 x64. Preview left the settings unchanged. Apply saved the local route. The CLI completed one stream through the installed engine to a local test provider. Undo restored the JSONC file byte for byte. [Clean OpenCode run](https://github.com/yukselbuilds/PennyPinch/actions/runs/45984452107)

The request preserved the model and synthetic authentication. The guest network stayed disconnected during the test. The live test has its own evidence below. [Evidence](../proofs/pennypinch-windows10-preview8-clean-install.json)

## 27 November — Native tray on clean Windows 10

A native close request hid the installed app on clean Windows 10 22H2 x64. The Windows tray menu reopened the same window. Pause and Resume kept the same engine generation. Quit required confirmation. The app stopped the three engine processes and released both loopback ports. [Clean tray run](https://github.com/yukselbuilds/PennyPinch/actions/runs/45992437027)

The test used a fresh Windows 10 guest with its network disconnected. Windows 11 checks remain open. [Evidence](../proofs/pennypinch-windows10-preview8-clean-install.json)

## 27 November — Codex connection on clean Windows 10

The installed app connected signed Codex CLI 0.166.0 on clean Windows 10 22H2 x64. The CLI confirmed ChatGPT sign-in. Undo restored the original TOML file byte for byte and released the connection. The test removed the temporary authentication file. [Clean Codex run](https://github.com/yukselbuilds/PennyPinch/actions/runs/46024916822)

The first test saved the route. The device code expired before sign-in. The second run did not verify a completed provider response or the Stop engine control. The test did not retain raw output. The cause of the unverified provider response is unknown. [Evidence](../proofs/pennypinch-windows10-preview8-clean-install.json)

## 27 November — Live Codex on clean Windows 10

The installed app connected Codex CLI 0.166.0 on clean Windows 10 22H2 x64. One short ChatGPT turn used the saved route and completed through the installed engine. The CLI usage matched one proxy record. Undo restored the original TOML file byte for byte. [Clean live Codex run](https://github.com/yukselbuilds/PennyPinch/actions/runs/46030502571)

The earlier run verified sign-in and Undo. Its provider response remained unverified. The owner used a separate ChatGPT Free profile for the new run. The test removed its temporary authentication data. Windows 11 x64 and live API-key coverage remain open. [Evidence](../proofs/pennypinch-windows10-preview8-clean-install.json)

<a name="açık-kabul"></a>

## Open acceptance criteria

**Windows 11 x64 portable engine.** The portable Headroom 0.45.0 engine reached Ready in 70.420 seconds on clean Windows 11 24H2 x64. The native core loaded offline. The engine stopped normally and released its port. The engine-only ZIP had 198,544,748 bytes. The test used a standard desktop user token. [Evidence](../proofs/pennypinch-windows11-portable-engine.json)

**Clean Windows 11 x64 desktop.** The published v0.1.1 installer opened PennyPinch as a standard user on clean Windows 11 24H2 x64. Headroom reached Ready in 79.842 seconds offline. Stop ended the engine in 2.099 seconds. Normal exit closed the local route. The guest had WebView2 before installation. [Evidence](../proofs/pennypinch-windows11-installed-lifecycle.json)

The 15 November private-repository check estimated ten standard Windows minutes from the reported $0.10 allowance. On 23 November, the GitHub API reported PennyPinch as public. Standard hosted jobs now run outside that allowance. The standard Windows x64 images still run Windows Server. The standard Windows 11 desktop image uses ARM64. Use the Windows 11 x64 guest for installed app verification. [GitHub Actions billing](https://docs.github.com/en/billing/concepts/product-billing/github-actions) · [Runner images](https://github.com/actions/runner-images#available-images)

CircleCI was also checked on 16 November 2026. The private repository can use the Free plan's 30,000 monthly credits. At 40 credits per minute, `windows.medium` would yield roughly 750 minutes if it used the entire quota. The official hosted Windows images are Server 2019 and Server 2022. They can cover builds and Server checks. Windows 11 x64 desktop acceptance needs its own environment. A self-hosted runner needs a host supplied by the user. [Windows images](https://circleci.com/docs/guides/execute/using-windows/) · [Free plan](https://circleci.com/pricing/) · [Credit rates](https://circleci.com/pricing/price-list/) · [Runner scope](https://circleci.com/docs/runner/runner-overview/)

Verify the client connection, one real request, Undo and the tray flow. Record the signed update and rollback in H042.

H048 and H049 track macOS and Linux ports and native CI. Each has its own workflow and acceptance evidence.

## 20 November — PennyPinch Windows 10 preview

PennyPinch is the app's display name and Windows installer name. Source and license notices identify Headroom 0.44.0 as the compression engine. The Windows installer and updater find earlier installations through the same registration. Shortcut migration applies to shortcuts that point to the existing application file.

`PennyPinch_0.1.0_x64-setup.exe` built on Windows 10 x64. The app and installer Windows product names matched. Verification covered 19,484 resources, 22 Windows packaging tests, 480 Rust tests and 227 frontend tests. A focused browser run found no violations across 60 Turkish and English accessibility audits. This evidence covers the build and installation identity checks. An in-place upgrade of an existing user profile has separate acceptance. [PennyPinch evidence](../proofs/pennypinch-application-brand.json)

## 20 November — Current branded Windows 10 preview

The installer built from `ab974e2` includes the new brand kit and settings guidance. The release application and NSIS wrapper have matching PennyPinch metadata and six icon sizes. The extracted application matched the built executable after the expected Tauri NSIS bundle marker was accounted for. All 19,484 expected resources matched the staging receipt. The extracted executable accepted the expected version probe and rejected a different version. The staged Headroom 0.44.0 engine reached ready and stopped. The installer was unsigned and its WebView2 prerequisite had a valid signature. Clean-host installation remains open. [Evidence](../proofs/pennypinch-windows10-preview.json)

## 20 November — PennyPinch Windows 10 delivery ZIP

The unsigned local ZIP includes the exact branded installer, 674 entries under `LICENSES/`, bilingual `README.txt` and `SHA256SUMS.txt`. The notice index binds the license files to the installer SHA-256 and the 0.44.0 engine. The pinned runtime, 258 Windows Rust dependencies and six frontend packages matched the verified source notices. Windows extracted all 677 entries into a path with Unicode and spaces, and all 676 listed hashes matched. A notice archive for a different installer and an attempt to overwrite the ZIP were rejected. [Evidence](../proofs/pennypinch-windows10-delivery.json)

To reproduce the ZIP from its verified local inputs, use the pinned build Python and the same receipt. The receipt pairs the archived installer with its extraction proof and matching notices. Clean-host and production delivery retain their own checks.

```powershell
& .\work\proofs\packaging\artifacts\headroom-engine-0.44.0\runtime\python.exe -I -B scripts/package-windows-delivery.py --receipt docs/proofs/pennypinch-windows10-notices.json
```
