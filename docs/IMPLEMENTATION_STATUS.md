# PennyPinch implementation status

## Current status

**47 of 54 main tasks are complete.** **12 subtasks remain open.** The Windows 10 v0.1.1 stable release is available. The Windows 11 portable engine passed. H041 remains open. [Task list](../TASKS.md)

PennyPinch v0.1.1 is available for Windows 10 22H2 x64. The full installer includes Headroom 0.45.0. The installer preserved preferences on upgrade from preview.8. The installed app applied the signed update from GitHub Pages and restored the earlier version. [Download](https://github.com/yukselbuilds/PennyPinch/releases/tag/v0.1.1) · [Evidence](proofs/pennypinch-windows10-stable-release.json)

The lead agent verified the H015 language change on Windows 10 22H2 x64. A new native profile opened in English. Settings saved Turkish. The second launch read the same preference file. 228 app tests and 482 Rust tests passed. The change is ready in source for a future release. [Evidence](proofs/english-first-launch.json)

PennyPinch v0.1.1-preview.8 is available for Windows 10 22H2 x64. The full installer includes Headroom 0.45.0. Both public downloads matched their SHA-256 digests. GitHub Pages links to the release. [Download the Windows preview](https://github.com/yukselbuilds/PennyPinch/releases/tag/v0.1.1-preview.8) · [Publication evidence](proofs/pennypinch-windows10-preview8-publication.json)

Use the full installer to install preview.8. The signed preview channel serves 0.1.1-preview.2 to compatible installations. The three signed feed files matched their recorded SHA-256 digests before and after publication. [Update status](https://yukselbuilds.github.io/PennyPinch/updates/)

The lead agent completed H042-ao on Windows 10. The public preview.5 showed a verification error for the older signed release. The corrected test build showed that the channel had no newer release. All 227 application tests and 481 Rust tests passed. The preview.6 installer carries the fix. [Evidence](proofs/windows-update-older-preview.json)

The lead agent completed H042-ap and H042-aq. The preview.6 installer upgraded preview.5 and kept the saved test preferences. The app found no newer release on the signed preview channel. A local Responses stream and normal exit passed. The public ZIP contains the tested installer and 673 third-party notices. Windows 11 x64 verification remains open. [Installed evidence](proofs/pennypinch-windows10-preview6-local.json) · [Publication evidence](proofs/pennypinch-windows10-preview6-publication.json)

The lead agent completed H042-ar. The Windows 10 Settings window showed the full installer instruction in Turkish and English. A newer signed manifest required a different engine pin. The app dropped the previous candidate and made no installer request. The local gate passed 228 app tests and 482 Rust tests. The published preview.6 predates this change. [Evidence](proofs/windows-update-full-installer.json)

The lead agent completed H042-as. The local preview.7 installer upgraded the public preview.6 on Windows 10. The app kept the saved test preferences. The installed engine completed a local Responses stream. The delivery ZIP contains the tested installer and 673 third-party notices. At this checkpoint, the public Windows 10 release was preview.6. [Local package evidence](proofs/pennypinch-windows10-preview7-local.json)

The lead agent completed H042-at. GitHub Releases serves preview.7 for Windows 10 22H2 x64. The public ZIP matched the installed upgrade, and five preflight cases passed. The signed preview feed serves preview.2 to compatible installations. [Publication evidence](proofs/pennypinch-windows10-preview7-publication.json)

The lead agent completed H042-au on Windows 10 22H2 x64. The local preview.8 installer upgraded the public preview.7 and kept the saved test preferences. The installed engine forwarded the repeated result and recovered the compressed log exactly. The ZIP contains the verified installer and 673 third-party notices. Publication is the next distribution step. [Local package evidence](proofs/pennypinch-windows10-preview8-local.json)

The lead agent completed H042-av. GitHub Releases serves preview.8 for Windows 10 22H2 x64. The public ZIP matched the tested installer. Five Windows 10 preflight cases passed. The signed preview channel serves preview.2. Windows 11 x64 update and rollback remain open. [Publication evidence](proofs/pennypinch-windows10-preview8-publication.json)

The lead agent completed H042-aw on Windows 10 22H2 x64. Each release executable accepted its own resource digest and rejected the other digest. The preview.7 verifier required the full installer for signed preview.8 test metadata. The preview.8 verifier found its own version current. The local checks took 19.908 seconds. Windows could not open the signing password backup. The live channel serves preview.2. Check older release verifiers before a production feed change. [Evidence](proofs/windows-preview8-update-compatibility.json)

The lead agent completed H042-ax on Windows 10 22H2 x64. Six release executables and 12 signed manifest checks passed in 17.606 seconds. Replacing the current preview record with preview.8 would remove the verified download path from preview.1 to preview.2. Preview.1 through preview.6 would show a verification error. The full installer remains the upgrade path for preview.8. Evaluate a separate feed URL for a future build before changing the current preview feed. [Evidence](proofs/windows-preview-feed-compatibility.json)

The lead agent completed H042-ay with an unsigned local installer on Windows 10 22H2 x64. The installer upgraded the public preview.8 to `0.1.1` in the same installation. The app kept its identifier and saved preferences. The app completed one local stream and closed normally. 228 app tests and 482 Rust tests passed. The next stable check is a signed update and rollback. [Evidence](proofs/windows-stable-installer-local.json)

The lead agent verified the Windows 10 stable update and rollback with a temporary key. Settings downloaded and applied `0.1.2` over `0.1.1`. Restore reopened `0.1.1` and recovered the original executable bytes. The preferences and Windows registration matched. Windows could not open the existing production signing password backup. Resolve signing access before publishing the stable feed. [Evidence](proofs/windows-stable-update-rollback-local.json)

The lead agent ran H037-a9 with the public preview.4 installer and a fresh application profile. The existing Windows 10 22H2 x64 desktop had WebView2. Default preferences, engine start, one local stream, normal exit, and cleanup passed in 73.966 seconds. The test matched 19,491 installed resources and the package receipt. [First-use evidence](proofs/windows-preview4-first-use.json)

The lead agent completed H037-a10 with the public preview.6 installer and fresh test profiles. On Windows 10 22H2 x64, the installed app connected Codex CLI to Headroom 0.45.0. One CLI turn completed against a loopback Responses provider. Undo restored the exact test configuration. Engine stop, normal exit, and cleanup passed. [First-use evidence](proofs/windows-preview6-first-use-codex.json)

The lead agent completed H037-a11 with the public preview.8 installer on Windows 10 22H2 x64. Connect saved the route for the isolated Codex CLI. The local Responses fixture received two complete copies of the tool result in one turn. Undo restored the CLI configuration byte for byte. Engine stop and cleanup passed. The clean Windows 10, Windows 11 x64, and WebView2 prerequisite checks remain open. Use this ZIP for the clean-host check. [First-use evidence](proofs/windows-preview8-first-use-codex.json) · [Windows procedure](validation/windows-preview-check.md)

The lead agent completed H037-a12 with the public preview.8 installer on Windows 10 22H2 x64. The local Claude Code stream and exact Undo passed. The full test took 87.866 seconds. Clean-host and live-provider checks remain open. Verify OpenCode first use with this ZIP and an isolated profile. [First-use evidence](proofs/windows-preview8-first-use-claude.json)

The lead agent completed H037-a13 with the public preview.8 installer on Windows 10 22H2 x64. The isolated OpenCode 2.3.0 profile passed two local streams and exact Undo. The run took 156.985 seconds. The public ZIP now has first-use evidence for three clients on this host. Check installation on a clean Windows 10 desktop when one is available. Windows 11 x64 and live-provider acceptance remain open. [First-use evidence](proofs/windows-preview8-first-use-opencode.json) · [Windows procedure](validation/windows-preview-check.md)

The lead agent completed H037-a14 with the public preview.8 installer on Windows 10 22H2 x64. An altered engine file blocked startup. Reinstalling the same release restored the engine and kept the test settings. The local stream and normal exit passed. The test took 112.582 seconds. The clean Windows and WebView2 installation checks remain open. Use the current ZIP for those checks. [Repair evidence](proofs/windows-preview8-repair.json) · [Windows procedure](validation/windows-preview-check.md)

The lead agent closed the existing H037 WebView2 prerequisite acceptance. The standard GitHub Actions job used a new Windows 10 22H2 x64 guest. The preview.8 installer registered the missing WebView2 Runtime as 158.0.4370.45. The first guest run ended 753.186 seconds after VM boot. The first run could not verify the window after setup. The second setup reached the 240-second test limit. [Evidence](proofs/pennypinch-windows10-preview8-clean-install.json)

The public preview.8 opened in a non-elevated session on a clean Windows 10 22H2 x64 guest. The guest test ended 764.600 seconds after boot. The test installed WebView2 from Microsoft's offline setup. [Evidence](proofs/pennypinch-windows10-preview8-clean-install.json)

The app bridge reported Stopped before the start test. The test reached the 155-second limit before it saw Ready. The primary control can show Start or Refresh status. The action sent on click and the final engine error are unknown. Require the Start label before the next click. Record engine states and the final error code.

The published preview.8 reported a timeout after Start on an offline Windows 10 guest. The lead agent set a 20-second preload budget for the candidate. With a controlled preload stall, local startup continued after 20.006 seconds. The staged controller reported Ready after 13.836 seconds on the Windows 10 development host. It stopped normally and released the engine port. The first guest run installed preview.8. The test runner stopped before it received a result for the candidate. [Startup evidence](proofs/pennypinch-windows10-preview8-clean-install.json)

The second guest run stopped during media preparation. A download returned exit code 28. The third run verified the media and installed preview.8. The runner reached its time limit before it reported that the guest had the candidate files. The clean engine lifecycle remains open. [Clean guest run](https://github.com/yukselbuilds/PennyPinch/actions/runs/45866157790)

The lead agent verified the H006 portable Windows 10 package and window. The packaged controller reached Ready in 73.718 seconds on the development host. The engine stopped normally and released its port. The clean guest timed out before Windows preflight. [Window test](https://github.com/yukselbuilds/PennyPinch/actions/runs/45897208162) · [Controller test](https://github.com/yukselbuilds/PennyPinch/actions/runs/45899760014) [Evidence](proofs/pennypinch-windows10-preview8-clean-install.json)

The earlier controller reached the startup deadline on clean Windows 10. The controller returned `helper_timeout`. The new Windows helper defers optional transform loading until first use. The startup deadline remains 90 seconds. The clean Windows 10 run logged the zero preload budget and loaded the native core. The controller still reported `helper_timeout`. [Earlier controller run](https://github.com/yukselbuilds/PennyPinch/actions/runs/45901530341) · [Updated controller run](https://github.com/yukselbuilds/PennyPinch/actions/runs/45904486183)

The updated packaged controller reached Ready in 13.338 seconds on the development host. It completed one loopback test request with optimization enabled and the native core loaded. It stopped normally and released its port. The clean test ran the packaged engine directly. The full installer needs its own lifecycle test. [Evidence](proofs/pennypinch-windows10-preview8-clean-install.json)

The earlier package bound its local port and loaded the native core. Its readiness endpoint returned HTTP 503 when the provider was unavailable. The updated package returned HTTP 200 with the same unavailable-provider fixture. The Windows helper matches the macOS readiness policy.

The packaged Headroom 0.45.0 engine reached Ready in 14.656 seconds on offline Windows 10 22H2 x64. The native core loaded. The engine stopped normally and released its port. The test observed the owned listener at 13.986 seconds. [Clean controller run](https://github.com/yukselbuilds/PennyPinch/actions/runs/45961626023)

This test covers the portable engine. The full installer, client connection, real request, and tray flow need separate evidence. [Evidence](proofs/pennypinch-windows10-preview8-clean-install.json)

The lead agent completed H037-a15. The current NSIS candidate installed for a standard user on clean Windows 10 22H2 x64. The Start control reached Ready in 31.203 seconds. The Stop engine control stopped the packaged processes in 1.182 seconds. The local route stayed open until the app exited. [Clean installation run](https://github.com/yukselbuilds/PennyPinch/actions/runs/45971537433)

The test installed the standalone WebView2 Runtime first. It kept the guest network disconnected. [Evidence](proofs/pennypinch-windows10-preview8-clean-install.json)

The lead agent completed H037-a16. The installed app found OpenCode 2.3.0 on clean Windows 10 22H2 x64. Preview left the settings unchanged. Apply saved the local route. The CLI completed one stream through the installed engine to a local test provider. Undo restored the JSONC file byte for byte. [Clean OpenCode run](https://github.com/yukselbuilds/PennyPinch/actions/runs/45984452107)

The lead agent corrected the test profile once. The original test policy blocked the local retrieval bridge. The request preserved the model and synthetic authentication. The guest network stayed disconnected during the test. The live test has its own evidence below. [Evidence](proofs/pennypinch-windows10-preview8-clean-install.json)

The lead agent completed H037-a17. A native close request hid the installed app on clean Windows 10 22H2 x64. The Windows tray menu reopened the same window. Pause and Resume kept the same engine generation. Quit required confirmation. The app stopped the three engine processes and released both loopback ports. [Clean tray run](https://github.com/yukselbuilds/PennyPinch/actions/runs/45992437027)

The first probe could not find the icon through UI Automation. The second probe could not move the guest pointer. The lead agent used Windows notification coordinates and sent clicks through the guest's virtual USB mouse. The test used a fresh Windows 10 guest with its network disconnected. Windows 11 checks remain open. [Evidence](proofs/pennypinch-windows10-preview8-clean-install.json)

The lead agent completed H037-a18. The installed app connected signed Codex CLI 0.166.0 on clean Windows 10 22H2 x64. The CLI confirmed ChatGPT sign-in. Undo restored the original TOML file byte for byte and released the connection. The test removed the temporary authentication file. [Clean Codex run](https://github.com/yukselbuilds/PennyPinch/actions/runs/46024916822)

The first test saved the route. The device code expired before sign-in. The second run did not verify a completed provider response or the Stop engine control. The test did not retain raw output. The cause of the unverified provider response is unknown. [Evidence](proofs/pennypinch-windows10-preview8-clean-install.json)

The lead agent completed H037-a19. The installed app connected Codex CLI 0.166.0 on clean Windows 10 22H2 x64. One short ChatGPT turn used the saved route and completed through the installed engine. The CLI usage matched one proxy record. Undo restored the original TOML file byte for byte. [Clean live Codex run](https://github.com/yukselbuilds/PennyPinch/actions/runs/46030502571)

The earlier run verified sign-in and Undo. Its provider response remained unverified. The owner used a separate ChatGPT Free profile for the new run. The test removed its temporary authentication data. Windows 11 x64 and live API-key coverage remain open. [Evidence](proofs/pennypinch-windows10-preview8-clean-install.json)

Verify the full installer and client flow independently on Windows 11 x64 when the owner resumes that check. [Procedure](validation/windows-preview-check.md)

The lead agent completed the existing H041 Next optimization slices item. The installed preview.8 evidence passed the exact-repeat and long-log checks. The matching 0.45.0 runtime passed 16 local test-output pairs on Windows 10. CCR returned 4 complete originals. The engine forwarded all 8 failed outputs in full. The task list had 17 open subtasks and 8 open main tasks. See the current H041 acceptance table for the remaining criteria. [Evidence](proofs/h041-core-optimization-completion.json)

The lead agent completed the existing H041-d Usage measurement for other protocols item. Windows 10 passed 32 local checks in 82.015 seconds. The native reader carried usage to Activity details on all three paths. The earlier live counter tests used Headroom 0.44.0. Live Anthropic and OpenAI API-key checks remain open. [Evidence](proofs/h041-usage-protocols-045.json)

The lead agent completed the H041-d usage measurement item on Windows 10 22H2 x64. The preview.8 engine matched all six Anthropic cases, and 35 focused tests passed. The installed window showed four output tokens and one attempt. The missing cache fields and total input stayed unknown. Live Anthropic Messages and the OpenAI API-key route have separate open items. [Evidence](proofs/h041-usage-across-calls-045.json)

The lead agent ran H041-a3 with Headroom 0.45.0 on Windows 10. The same 300-second plan passed 300 request pairs and 249 exact CCR recoveries. Extra p95 latency was 47.87 ms. The engine stopped and released its port. All four fixtures matched the 0.44.0 token counts. [Timed load evidence](proofs/optimization-windows10-stability-045.json)

The source pins Headroom 0.45.0. Windows 10 built the local installer and passed the staged engine lifecycle and loopback usage tests.
Ubuntu 24.04 x64 and macOS 26 ARM64 passed direct engine checks. [Engine verification](proofs/headroom-045-upgrade.json)

The matched Windows 10 benchmarks produced equal counts on both engines in all 33 SDK and eight proxy cases.
In six headline cases, the proxy reduced the count from 122,944 to 69,350 tokens (43.59%).
HTML extraction returned F1 of 0.9168. The tests used local fixtures and zero model calls. [Benchmark evidence](proofs/upstream-benchmarks-045.json).

The lead agent updated the Unix status adapter. The local window build and quality gate passed with 522 matching inputs.
The Ubuntu 24.04 x64 package passed install, start, stop, restart, exit, and purge checks on GitHub Actions.
The macOS 26 ARM64 package passed a controlled Codex Desktop turn, stored local usage, and exited normally. The probe and input comparison finished at the time limit. GitHub marked the overall job cancelled. [Native job](https://github.com/yukselbuilds/PennyPinch/actions/runs/45271792284).
Luna reviewed the upstream sources. Development token savings remain unknown.
[Package and adapter evidence](proofs/headroom-045-managed-packages.json)

The stock Headroom 0.45.0 proxy and PennyPinch forwarded the same JSON in eight matched Windows 10 cases. The six headline cases returned 43.59% fewer tokens in both proxies. The SDK uses a message estimator. [Matched comparison](proofs/upstream-benchmarks-045.json).

Codex CLI 0.171.0-alpha.13.2 opened both synthetic files under the built-in read-only profile on Windows 10. The unelevated backend refused the named profiles before the command started. MXC was unavailable. These local checks did not verify the named profile on Windows 10. [File scope evidence](proofs/targeted-query-comparison.json) · [Open H041 criteria](validation/optimization-benefit.md#open-h041-acceptance-criteria)

On 26 November 2026, CLI 0.171.0-alpha.13.2 requested sandbox setup on Windows 10. The isolated elevated control timed out before the read command started. The test added no deny-read entries. The elevated check remains unverified on that Windows 10 host. [Windows sandbox requirements](https://learn.chatgpt.com/docs/windows/windows-sandbox#configure-a-legacy-fallback)

The lead agent verified the native Codex file profile on the standard Windows Server 2025 x64 runner. The profile returned the exact 35 approved bytes and denied the second file. Switching profiles left the read denial in place. The runner kept the test settings within a disposable VM. The check matched seven input hashes and made zero model requests. [Evidence](proofs/targeted-query-comparison.json) · [GitHub run](https://github.com/yukselbuilds/PennyPinch/actions/runs/45819720053)

The lead agent rechecked targeted query readback with Headroom 0.45.0 and Codex CLI 0.171.0-alpha.13.2. Windows 10 passed all four scenarios, 34 loopback requests, and 23 focused tests. The CLI restored 107,498 original bytes. A foreign archive and disabled Read remained inaccessible. Actual provider billing remains open. [Current evidence](proofs/targeted-query-default-budget.json)

The lead agent completed the Learn suggestion benefit pilot on Windows 10. Eight previews passed with the current inputs. Both arms chose the older source in the first run. The lead agent clarified the read options. Both arms then answered two release checks correctly. No retries occurred. The advice increased local usage from 459 to 515 tokens (12.20%). Keep the suggestion in the opt-in preview. [Learn evidence](proofs/learn-merit-pilot.json)

The lead agent completed broader Learn measurement on Windows 10. OpenCode 1.19.3 used the same Qwen3.8-Flash-Next settings in both arms. The two release checks were correct in both arms. Both arms had zero retries, incorrect reads, and extra path checks. All eight provider counters matched the 0.45.0 engine. Learn increased total usage from 1,136 to 1,188 tokens (4.58%). The anonymous provider received only public release facts and the fixed test text. [Learn evidence](proofs/learn-merit-pilot.json)

The lead agent ran the pinned upstream Learn suite on Windows 10. The 18 test modules passed 478 tests and skipped eight. All 44 inputs matched. The isolated run used no active session files and made zero external model requests. The release keeps Learn as a user-selected local preview. [Evidence](proofs/learn-merit-pilot.json)

The lead agent prepared the live Anthropic Messages check. One loopback SSE response matched the engine usage record. The test made no provider request and stopped the engine normally. The live check awaits authorized access to a free-credit test account. [Open criteria](validation/optimization-benefit.md#open-h041-acceptance-criteria)

The lead agent corrected exit-code handling for Codex `exec_command` on Responses. Successful compression keeps the exit code visible. Failed output stays intact. HTTP/SSE and WebSocket passed eight local pairs each on Windows 10. [Shell status evidence](proofs/responses-shell-status-045.json)

The lead agent tested exact Responses repeats with Headroom 0.45.0 and SmolLM2 on Windows 10. In four paired tasks, the full-output arm answered three correctly. The reference arm answered two correctly. Model input fell from 1,420 to 964 tokens. The quality criterion failed. [Evidence](proofs/responses-repeat-local-model-045.json)

The lead agent removed Responses repeat references from the 0.45.0 runtime. Windows 10 passed 52 wire checks, three exact CCR recoveries, 228 app tests, and 482 Rust tests. The local model matched the full-output control on all four answers and token counts. The correction requires a new Windows package. Resume verification from the open H041 criteria. [Correction evidence](proofs/responses-repeat-output-045.json) · [Open criteria](validation/optimization-benefit.md#open-h041-acceptance-criteria)

The preview.5 full installer upgraded the public preview.4 on Windows 10 22H2 x64. It preserved preferences. The test matched 19,491 installed resources and the package receipt. The installed engine passed the successful and failed output checks with the same inputs in both versions. The older installer refused the downgrade. [Installed evidence](proofs/windows-preview5-shell-upgrade.json)

The lead agent prepared the preview.5 delivery for H042-am. The ZIP includes the release notes and 673 third-party notices. Windows matched all 678 listed SHA-256 digests and the tested installer. [Delivery evidence](proofs/pennypinch-windows10-preview5-delivery.json)

The lead agent completed H042-an. The release tag points to the tested source. The downloaded installer matched the Windows 10 upgrade test. Three Pages links pointed to preview.5 at publication. The desktop check script accepted the ZIP on Windows 10. Use the current ZIP and the signed rollback procedure when a Windows 11 x64 desktop is available. [Publication evidence](proofs/pennypinch-windows10-preview5-publication.json)

Ubuntu passed the configuration transaction and recovery checks on ext4. [H049-b2 evidence](proofs/h049-linux-transaction.json)

The lead agent completed H049-b3 on Ubuntu 24.04 x64. The desktop manager ran Headroom 0.44.0 and forwarded a local Responses stream from the saved Codex endpoint.
Apply and Undo passed for isolated Codex, Claude Code, and OpenCode settings. [H049-b3 evidence](proofs/h049-linux-managed.json)

Ubuntu 24.04 x64 passed H049-b4. PennyPinch found the three pinned native CLI files without starting them. The app saved explicit choices and restored them on the next scan. [H049-b4 evidence](proofs/h049-linux-discovery.json)

H049 is complete for Ubuntu 24.04 x64. The installed Debian package passed the native window and engine lifecycle checks. The package is a CI test candidate. Distribution release checks remain separate. [Linux validation](validation/linux.md)

The lead agent verified the H049-b4 regression on macOS 26.7.2 ARM64. The job passed 16 Rust tests, the frontend build, and the locked native build. GitHub cancelled the macOS 15 job before runner assignment. [Regression evidence](proofs/h049-macos-cli-regression.json)

GitHub lists free standard hosted compute for public repositories. Standard Windows x64 runners use Windows Server. The standard Windows 11 desktop runner uses ARM64. Full Windows 11 x64 desktop acceptance remains open. [Windows acceptance](validation/windows-install.md#open-acceptance-criteria)

The lead agent completed H006 with the portable engine from the published v0.1.1 installer. The portable Headroom 0.45.0 engine reached Ready in 70.420 seconds on clean Windows 11 24H2 x64. The native core loaded offline. The engine stopped normally and released its port. The engine-only ZIP had 198,544,748 bytes. The test used a standard desktop user token. [GitHub run](https://github.com/yukselbuilds/PennyPinch/actions/runs/46140058906) · [Evidence](proofs/pennypinch-windows11-portable-engine.json)

The full Windows 11 run reached the system disk and passed the clean install and offline engine lifecycle. The app verified the stable manifest. The download test reached its deadline. [First desktop run](https://github.com/yukselbuilds/PennyPinch/actions/runs/46147672114) · [Evidence](proofs/pennypinch-windows11-installed-lifecycle.json)

The retest waits for the app download and extraction limits. The earlier retest timed out before first sign-in. The new run saves the guest screen if setup stops. [Desktop retest](https://github.com/yukselbuilds/PennyPinch/actions/runs/46152291961)

### Windows release evidence

H037-a8 passed. The public Windows 10 preview ZIP download resumed at 8 MiB. The complete SHA-256 and 673 indexed license and notice files matched the delivery record. The next H037 check requires a clean Windows desktop without WebView2. [Public delivery evidence](proofs/windows-installer-public-preview-resume.json) · [Open installation checks](validation/windows-install.md#open-acceptance-criteria)

The extracted Windows 10 x64 payload passed a live Codex CLI turn. The provider usage matched, and the engine stopped gracefully. [Evidence](proofs/pennypinch-windows10-packaged-codex.json)

An earlier Windows 10 preview installed on this host. PennyPinch saved the test route. A new ChatGPT CLI used it. Activity showed an earlier record from the run. The built-in verifier stopped at the ancestor configuration guard for this profile. Disconnect restored the test configuration. The application closed normally. [Installed flow](proofs/pennypinch-windows10-installed-codex.json)

The updated Windows 10 installer passed live Codex savings verification in Activity. The local pair and the provider count were verified separately. The original WebSocket feed uses the provider count plus a local delta, so its ratio is historical only. [Measurement](proofs/pennypinch-windows10-activity-measurement.json)

The lead agent prepared the delivery ZIP and verified extraction on Windows 10. [Package record](proofs/pennypinch-windows10-activity-delivery.json)

The current Windows 10 release code verified a local signed update with a temporary key. The verifier rejected the earlier preview's runtime resource digest. The live update URLs returned HTTP 404. [Preflight record](proofs/pennypinch-windows10-update-preflight.json)

The PennyPinch project site serves the update address over HTTPS. The preview channel serves signed updates. [Repository](https://github.com/yukselbuilds/PennyPinch) · [Update address](https://yukselbuilds.github.io/PennyPinch/updates/)

The public README and project site show the benchmark results and measurement scopes. The repository description and topics identify PennyPinch and its client coverage. [Presentation checks](proofs/pennypinch-public-showcase.json)

The local signing key and same-profile encrypted backup passed a signing check. The signed preview channel serves v0.1.1-preview.2. The Windows 10 update manager verified its signature, download, and extracted application. [Signed preview evidence](proofs/pennypinch-windows10-signed-preview.json)

On Windows 10, the real installation upgraded from v0.1.0 with the full installer. Settings then applied the signed v0.1.1-preview.2 package. Rollback restored the previous executable and Windows registration. The test preferences matched across both restarts. The 19,484 recorded resource files matched after rollback. [Installed acceptance](proofs/pennypinch-windows10-installed-update-and-release.json)

The lead agent completed H044-d with the Headroom 0.45.0 payload. In 108 local requests, RTK reduced the first matching request from 156 to 154 tokens. Full readback needed two additional calls and 4,947 more bytes. H044 remains deferred. Resume when an eligible route shows a net benefit and a verified client recovery path. [Current evidence](proofs/rtk-1.2.1-rg-045.json)

The 23 November check found RTK-OSS v1.2.1 is still the latest stable release. The paired evidence applies to that release. [Upstream release](https://github.com/rtk-ai/rtk/releases/tag/v1.2.1)

### Reporting pilot

The lead agent completed the H052 PostgreSQL port because it changes persistent data and quota handling. All 26 report service tests passed in 2.443 seconds. Native PostgreSQL 17.12 tests passed in 5.348 seconds. The lead agent deleted the previous empty pilot database after the owner approved this action. [PostgreSQL evidence](proofs/h052-postgres-port.json)

The lead agent applied H052-h to the Neon Free pilot in Frankfurt. PostgreSQL 18.7 accepted the migration in one transaction. The synthetic storage checks took 177 milliseconds. The catalog confirmed the function matches the migration source. The catalog lists direct grants to the object owners only. The test rolled back all rows. [Neon migration evidence](proofs/h052-neon-migration.json)

The lead agent implemented H052-i because it defines database access. The Neon pilot passed the service role checks. The probe inserted and read synthetic rows, checked denied actions, and rolled back all writes. All 28 local service tests passed. On Node.js 24, the Function bundle passed TLS, retry, and idle disconnect recovery checks against native PostgreSQL. [Role and Function evidence](proofs/h052-neon-runtime.json)

The lead agent deployed the closed H052-j Function on Neon Free in Frankfurt. All four requests returned 404 with no-store. The operator connected to PostgreSQL with TLS. The probe confirmed an empty pilot and a disabled runtime login. The lead agent revoked the project key. Neon showed the key removed after reload. [Live evidence](proofs/h052-neon-closed-function.json)

The lead agent completed H052-j on a temporary branch from the verified empty pilot. The hosted probe returned 204 with a restricted role. PostgreSQL denied three restricted operations. The test denied login after revocation and verified branch removal. Four parent routes returned 404. Neon confirmed removal of the project API key. [Live connection evidence](proofs/h052-neon-restricted-connection.json)

The lead agent implemented H052-k because it controls deletion. All 34 local reporting tests passed. Native PostgreSQL verified TLS and the cleanup role. The first invocation removed 4,000 expired rows. A retry removed the final expired row. The test preserved the rows at the retention boundary. H052-q covers the deployed role and schedule. The earlier Function probe inputs still match. [Cleanup evidence](proofs/h052-neon-retention-local.json)

The lead agent implemented H052-l because it controls administrator access. The local Function uses the Managed Better Auth token contract. It requires the configured issuer, audience, and administrator subject. The packaged handler verified a test session and read a summary over TLS from native PostgreSQL. All 38 local reporting tests passed. H052-p verified the signed token contract on Neon Free. [Administrator access evidence](proofs/h052-neon-admin-local.json)

The lead agent implemented H052-m because it handles browser credentials. The Function bundle passed the login and sign-out flows in isolated Edge. The tests used synthetic provider responses and confirmed same-origin form requests. All 41 local reporting tests passed. The connection probe inputs still match. H052-p verified the browser flow with the real Auth provider. [Browser access evidence](proofs/h052-neon-admin-browser-local.json)

The lead agent implemented H052-n because it controls deletion during recovery. Native PostgreSQL copied synthetic report data from before an erasure. Recovery removed two erased reports, their rate row, and 4,001 expired reports. Two cleanup passes preserved the current record and daily quota. The operator kept report routes closed until cleanup finished. The report service rejected a revoked uploader after reopening. All 43 local reporting tests passed. H052-r covers Neon point-in-time recovery. [Restore evidence](proofs/h052-neon-restore-local.json)

The lead agent completed the H052-o disclosure review on the private report response. The local fixture used 21 synthetic installations. An initial response covered 20 installations overall. One measurement basis exposed one contributor. Two overlapping totals also revealed an exact contribution. Keep the aggregate response private. Real report intake remains closed. [Disclosure evidence](proofs/h052-aggregate-disclosure.json)

The lead agent completed H052-p because it controls administrator access. Edge tested two synthetic users on a temporary Neon Free branch in Frankfurt. The allowed user read the private summary. The other user and an invalid password returned 401. Sign-out removed the browser cookie and closed the summary. The test found zero provider sessions. The lead agent removed the branch and revoked the API key. H052-q covers scheduled cleanup. [Live sign-in evidence](proofs/h052-neon-admin-live.json)

The lead agent implemented H052-q because it controls deletion and trigger authentication. A scheduled call reached the Function over internal HTTP. The previous handler returned 404 before it queried PostgreSQL. The fix accepts the internal call with the trusted Neon header and matching envelope. All 43 local reporting tests passed. On Neon Free, the first call removed 4,000 expired synthetic reports. A retry removed the final expired report after 62 seconds. The cutoff report and current counters remained. The lead agent removed the test schedule and branch and revoked the key. H052-r covers point-in-time recovery. Provider logging, privacy acceptance, and production enrollment remain open. [Live retention evidence](proofs/h052-neon-retention-live.json)

The lead agent ran H052-r because it controls restoration, deletion, and access. Neon Free recovered the synthetic source at its exact pre-erasure write-ahead log position. Two cleanup passes removed two erased reports, one rate row for the erased installation, and 4,001 expired reports. The operator kept report routes closed during both passes. The private test handler connected over TLS with the restricted role. It rejected the old uploader and returned one retained report to the verified test operator. The lead agent revoked the login and project key and removed both temporary branches. H052-s covers the backup inventory and visible logs. Production cutover remains open. [Live restore evidence](proofs/h052-neon-restore-live.json)

The lead agent ran H052-s on the closed Neon Free pilot. The project API returned a six-hour restore window, one branch, and zero snapshots. The backup schedule API returned an empty list. A rejected synthetic upload produced one start record and one end record. Neither record contained the test report identifier, token, or query marker. The lead agent revoked the temporary project key. H052-t covers the public terms and transfer review. Internal retention and account evidence remain open. Real report intake stays closed. [Provider evidence](proofs/h052-neon-provider-retention.json)

The lead agent completed the H052-t public terms review. The current Neon schedule refers to the Databricks agreement and Data Processing Addendum. The schedule lists a US infrastructure subprocessor. The public KVKK rules require a separate transfer basis for regular reports. Confirm the account terms and recipient. Verify the Article 9 safeguard, internal retention, operator, and rights contact before production. Keep real intake closed. [Terms review](proofs/h052-neon-processing-terms.md)

On 25 November, the owner deferred H052, H053 and H054 from the first release. The lead agent recorded the decision. The H052-u inquiry remains a local draft. Keep real report intake closed. Resume the account, retention, and transfer checks before production. [Scope decision](decisions/032-usage-sharing-privacy.md#25-november--first-release-scope)

### Public privacy and presentation

The two public branches and two release tags use the rewritten Git history. On 24 November the GitHub Support portal showed the removal request as Open. The portal showed only the original request. Verify anonymous access after Support replies.

GitHub About, README, and Pages now describe separate platform statuses. The live release asset IDs, SHA256 values, and signed update files matched. Secret Protection, push protection, and Dependabot alerts are on.

The lead agent completed H042-ak. The public ZIP contains the installer that passed the Windows 10 upgrade. The public download pages link to the release. All three signed update files kept their digests. H042 still needs an installed update and rollback on Windows 11 x64. [Publication evidence](proofs/pennypinch-windows10-preview4-publication.json)

The lead agent prepared the H042-al Windows desktop checks. The script reads the OS build, processor architecture, ZIP digest, and WebView2 registration. Six Windows 10 cases and four simulated OS cases passed in 8.822 seconds. Run the current installer and signed rollback procedures on Windows 11 x64 when a desktop is available. [Procedure](validation/windows-preview-check.md) [Preflight evidence](proofs/windows-preview-preflight.json)

Tokio 1.54.1 passed the Windows 10 product gate and signed update package checks with an isolated key. The real QA app passed signature, resource pin, extraction, and probe validation. [Tokio verification](proofs/tokio-windows-1541.json) · [Public privacy and presentation checks](proofs/pennypinch-public-privacy.md)

OpenTelemetry API 1.45.2 passed the Windows 10 product gate, the staged engine lifecycle test, and a local Responses stream. The local NSIS installer contains the patched package. Existing installations require the full installer for the new engine resources. [OpenTelemetry verification](proofs/opentelemetry-windows-1452.json)

The lead agent applied the upstream `glib` fix to the Linux GTK3 dependency. The locked Ubuntu 24.04 x64 build opened PennyPinch under Xvfb. Dependabot closed alert #2 as fixed. [Security verification](proofs/glib-0429-linux-backport.json)

The local 0.1.1-preview.3 full installer upgraded the public Windows 10 preview. The installed runtime reports OpenTelemetry API 1.45.2. The app kept the test preferences and started and stopped the engine. Windows 11 checks remain open. [Installed verification](proofs/opentelemetry-windows-installed-upgrade.json)

The v0.1.1-preview.3 ZIP passed Windows extraction with 677 matching digests. The signed update files kept their recorded digests. [Delivery evidence](proofs/pennypinch-windows10-preview3-delivery.json) · [Release notes](releases/0.1.1-preview.3-windows10.md)

## History

The repository documentation is in English. The archive keeps earlier handoffs, measurements, and their original acceptance limits. [Implementation history](IMPLEMENTATION_HISTORY.md) · [English documentation check](proofs/pennypinch-final-implementation-history-english.json)
