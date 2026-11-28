<h1 align="center">
  <picture>
    <source media="(prefers-color-scheme: dark)" srcset="docs/branding/pennypinch-horizontal-dark.png">
    <img src="docs/branding/pennypinch-horizontal-light.png" alt="PennyPinch" width="350">
  </picture>
</h1>

<p align="center"><strong>Local context compression and token tracking for AI coding tools.</strong></p>

<p align="center">
  <a href="https://yukselbuilds.github.io/PennyPinch/"><img src="docs/branding/readme-site.png" width="126" height="38" alt="Project site"></a>
  <a href="https://yukselbuilds.github.io/PennyPinch/#benchmarks"><img src="docs/branding/readme-benchmarks.png" width="130" height="38" alt="Measured input-token results"></a>
  <a href="https://github.com/yukselbuilds/PennyPinch/releases"><img src="docs/branding/readme-releases.png" width="147" height="38" alt="GitHub Releases"></a>
</p>

<p align="center">Windows 10 22H2 x64 stable release · <a href="#platform-validation">macOS and Linux status</a> · Apache License 2.0</p>

<p align="center">
  <a href="https://yukselbuilds.github.io/PennyPinch/#benchmarks"><img src="docs/branding/pennypinch-benchmarks.png" alt="Windows 10 local proxy test. Six synthetic requests fell from 122,944 to 69,350 input tokens, a reduction of 43.59%." width="100%"></a>
</p>

PennyPinch is an open-source desktop app for local context compression with Codex, Claude Code, and OpenCode. Connect a supported route to Headroom and see the input token change in Activity. Your client keeps control of its model, reasoning level, and sign-in.

## Download PennyPinch for Windows 10

The Windows 10 22H2 x64 installer includes Headroom 0.45.0. Use the full installer to upgrade from preview.8. PennyPinch verifies signed updates in Settings. The NSIS installer is unsigned.

[**Download the Windows 10 release**](https://github.com/yukselbuilds/PennyPinch/releases/tag/v0.1.1) · [Update status](https://yukselbuilds.github.io/PennyPinch/updates/) · [Platform validation](docs/validation/desktop-platforms.md)

## What PennyPinch does

- **Connect supported clients.** Scan local installations, review the detected target, and confirm a route. You confirm each connection after discovery.
- **Measure local input changes.** Overview compares before and after input counts when the recorded basis supports that comparison. Missing or mixed measurements remain unknown. A measured zero remains zero.
- **Keep controls explicit.** Pause affects new compression requests. The client continues to control its model, reasoning, and authentication.
- **Keep usage reports local.** PennyPinch stores measurements on your device. You can export a content-free report. The Headroom usage beacon starts off.

See how to connect and review traffic in the [user guide](docs/USER_GUIDE.md).

## Measured input-token results

On Windows 10, Headroom 0.45.0 and PennyPinch forwarded the same request JSON in all eight test cases. Both proxies reduced the count by 43.59% in the six headline cases. The SDK estimates tokens in messages. The proxy test counts the full request JSON with `o200k_base`. [Matched comparison](docs/proofs/upstream-benchmarks-045.json)

| Test scope | Before → after input count | Result | Counter and limit |
| --- | ---: | ---: | --- |
| Six synthetic Chat Completions requests through each proxy, Headroom 0.45.0 | 122,944 → 69,350 | **43.59% lower** | The full request JSON count. The test used a local fixture and zero model calls. [Request counts](docs/proofs/upstream-benchmarks-045.json) |
| One real Codex CLI Responses WebSocket request through the installed Windows app | 18,081 → 17,870 | **211 fewer · 1.17% local estimate** | One matched local pair from Headroom 0.44.0. The provider reported 10,780 input tokens separately. [Measurement](docs/proofs/pennypinch-windows10-activity-measurement.json) |
| Six selected examples from the Headroom SDK benchmark, rerun with Headroom 0.45.0 | 126,289 → 55,209 | **56.28% lower** | Headroom's `benchmark-model` estimates message tokens. [SDK counts](docs/proofs/upstream-benchmarks-045.json) · [Pinned benchmark source](https://github.com/headroomlabs-ai/headroom/blob/ce0460cfa8598dc939243dbc7aec4b2d35f4e44a/docs/content/docs/benchmarks.mdx) |
| One paired task on a local model server | 6,647 → 6,647 | **0% change** | Both routes used the same log task and local model. The proxy used Headroom 0.44.0. The model server supplied both counts. [Comparison method](docs/validation/optimization-benefit.md#19-kas%C4%B1m--ger%C3%A7ek-yerel-modelde-e%C5%9Flenmi%C5%9F-chat-completions-k%C4%B1yas%C4%B1) |

<details>
<summary>See the six synthetic proxy cases</summary>

The counts match for the Headroom 0.45.0 and PennyPinch proxies. The Python source stayed exact. A streaming usage field added eight tokens to its request JSON.

| Synthetic input | Direct | Through either proxy | Change |
| --- | ---: | ---: | ---: |
| JSON search results · 100 items | 9,521 | 5,733 | 39.79% lower |
| JSON search results · 500 items | 46,794 | 27,768 | 40.66% lower |
| Structured logs · 100 entries | 8,661 | 5,680 | 34.42% lower |
| Structured logs · 500 entries | 40,527 | 25,942 | 35.99% lower |
| Documentation | 14,499 | 1,277 | 91.19% lower |
| Python source · about 200 lines | 2,942 | 2,950 | 0.27% higher |

[Full counts and method](docs/proofs/upstream-benchmarks-045.json) · [Optimization validation](docs/validation/optimization-benefit.md#24-november--matched-headroom-0450-comparison)

</details>

## Client coverage

Coverage applies to the recorded version, surface, authentication method, route, and operating system. A chat or subagent appears in measurements when its requests use the verified route.

| Client | Recorded evidence | Limit |
| --- | --- | --- |
| Codex CLI and Desktop | Tests observed ChatGPT traffic on selected Windows 10 versions. A separate 0.44.0 preview measurement covers one live CLI request. [CLI evidence](docs/proofs/codex-native-wait.md) · [Desktop evidence](docs/proofs/codex-desktop-live.md) · [0.44.0 measurement](docs/proofs/pennypinch-windows10-activity-measurement.json) | The CLI parent/child check and Desktop chat evidence have separate scopes. Other accounts, versions, chats, and routes have separate validation. |
| Claude Code 2.1.158 | Windows 10 connection checks used synthetic credentials and a local provider. [Evidence](docs/proofs/claude-acceptance.md) | Live provider authentication and other surfaces require separate checks. |
| OpenCode V1 1.19.3 and V2 2.3.0 | Selected Windows 10 CLI, TUI, and packaged Desktop service routes used synthetic credentials and local providers. [Evidence](docs/proofs/opencode-acceptance.md) | The evidence has separate limits for each version and surface. |

See the [versioned compatibility records](compatibility/clients.json) for status by exact client version and surface.

## Platform validation

| Platform | What the current record verifies | Still open |
| --- | --- | --- |
| **Windows 10 22H2 x64** | v0.1.1 upgraded preview.8 and kept its preferences. The installed app applied a signed update from GitHub Pages and restored the earlier version. [Release evidence](docs/proofs/pennypinch-windows10-stable-release.json) | Live Anthropic and OpenAI API-key validation have separate requirements. |
| **macOS ARM64** | On macOS 26.7.2, the test package started Headroom 0.45.0. A controlled Codex Desktop turn returned a response and stored local usage. The package exited normally. [Package evidence](docs/proofs/headroom-045-managed-packages.json) | Production signing, notarization, live provider traffic, and release delivery require separate checks. |
| **Ubuntu 24.04 x64** | The Debian package installed. The app started, stopped, and restarted Headroom 0.45.0 under Xvfb. Package purge retained the separate user state. [Linux validation](docs/validation/linux.md) | Live provider use and public Linux distribution require separate checks. |
| **Windows 11 24H2 x64** | Clean install, offline engine controls and normal exit passed. [Evidence](docs/proofs/pennypinch-windows11-installed-lifecycle.json) | Client, tray and signed update verification remain open. |

The current source pins Headroom 0.45.0. The upgrade record covers the Windows 10 package and the direct engine checks.
[Engine verification](docs/proofs/headroom-045-upgrade.json) · [Full platform status](docs/validation/desktop-platforms.md)

## Local data and reports

PennyPinch keeps measurements on the device. Activity and usage exports contain allow-listed request metadata, such as client, model, and token counts. Diagnostic exports omit credentials and raw request content. You start each export. The Headroom usage beacon starts off.

The engine can temporarily keep original compressed content in its local retrieval store so the client can recover it. Your connected client still uses its selected model provider. [Application data boundaries](docs/SECURITY_BOUNDARIES.md)

## License and credits

The PennyPinch desktop application source is available under the [Apache License 2.0](LICENSE). Bundled components keep their respective licenses and attribution in [NOTICE.md](NOTICE.md).

PennyPinch uses the [Headroom compression engine](https://github.com/headroomlabs-ai/headroom). Thanks to the Headroom contributors.

<details>
<summary>Build the frontend and Windows preview</summary>

The app uses Tauri 2, Rust, React, and TypeScript. The source-only frontend checks use the checked-in package and lockfiles. Use Node.js 25.2.1 from `.node-version` and pnpm 11.25.0:

```powershell
pnpm --store-dir work/caches/pnpm install --frozen-lockfile
pnpm test:app
pnpm build
```

`test:app` runs the app contract tests. `build` checks TypeScript and builds the frontend.
The Windows build needs the Headroom 0.45.0 payload from the development manifest.
The payload and some historical protocol test helpers are in the Git-ignored `work/` directory.
[Package scripts](package.json) · [Source check scope](docs/validation/source-checks.md) · [Development manifest](runtime/manifest.json)

With the pinned development toolchain and engine payload already prepared locally, build the Windows preview:

```powershell
pnpm.cmd build:windows
```

This verifies and stages the engine, then builds an x64 current-user NSIS preview under `work/caches/cargo-target/release/bundle/nsis/`. The installed app requires WebView2. If it is missing, the embedded bootstrapper needs internet access. The installer rejects destinations longer than 100 UTF-16 units.

The Windows package keeps the engine in `runtime/payload` and stores app state under LocalAppData.
The Headroom 0.45.0 payload contains 19,483 files and 505,296,374 bytes before installer compression.
[Payload inventory](runtime/windows-payload.json) · [Vendor notices](NOTICE.md) · [Installer validation](docs/validation/windows-install.md)

</details>
