# homebrew-tap

Homebrew formulae and casks maintained by [jlikeme](https://github.com/jlikeme).

| Package | Type | Description |
| --- | --- | --- |
| [HoRNDIS Userspace](https://github.com/jlikeme/HoRNDIS-Userspace) | Cask | Android USB tethering on macOS, with optional Surge and ADB automation |
| [imsg](https://github.com/jlikeme/imsg) | Formula | Send, read, and stream iMessage and SMS from the terminal |

## HoRNDIS Userspace

Installs the enhanced HoRNDIS distribution from
[jlikeme/HoRNDIS-Userspace releases](https://github.com/jlikeme/HoRNDIS-Userspace/releases).
The universal package supports Apple silicon and Intel Macs. It provides a menu
bar app and the `horndis` command without a kernel extension or SIP changes.

Optional features include SIM DNS and Intelligence integration with Surge,
automatic USB tethering startup through an already-authorized ADB connection,
and preservation of the HoRNDIS USB network service during upgrades and reinstalls.
Version 0.3.12 also saves the service UUID and relative position for startup
recovery. New services are named **HoRNDIS USB**, enable IPv4 DHCP, and appear
last by default.

Version 0.3.13 fixes the local-network permission regression in the v0.3.12
ad-hoc distribution. The app and helpers use stable Apple-issued signatures;
allow **HoRNDIS Status** local network access if macOS asks after upgrading.

### Install

```sh
brew install --cask jlikeme/tap/horndis
```

Equivalent two-step form:

```sh
brew tap jlikeme/tap
brew install --cask jlikeme/tap/horndis
```

### Upgrade or reinstall

```sh
brew update
brew upgrade --cask jlikeme/tap/horndis
```

To reinstall the same version:

```sh
brew reinstall --cask jlikeme/tap/horndis
```

With the enhanced package installed, replacement stops its background jobs and
reuses the existing HoRNDIS USB service, preserving its identifier, network
configuration and service order. Startup reuses the saved UUID; when rebuilding
is necessary, it restores the previous relative position without reordering
other services. Older upstream installations have a different
saved uninstaller; see the project's [upgrade guide](https://github.com/jlikeme/HoRNDIS-Userspace/blob/main/docs/USER_GUIDE.md#upgrade)
for the first migration.

### Uninstall

```sh
brew uninstall --cask jlikeme/tap/horndis
```

A full uninstall removes the application's background services and its owned
HoRNDIS USB network service and its saved recovery record. A later fresh install
creates a new service with DHCP enabled at the end of the service list.

### Requirements and first launch

- macOS 11 (Big Sur) or newer, on Apple silicon or Intel.
- An Android phone exposing RNDIS USB tethering and a data-capable USB cable.
- Administrator authorization to install the fixed background network helper.
- Allow local network access for **HoRNDIS Status** when macOS requests it, so
  phone DNS checks and Surge integration can work.
- Automatic USB startup additionally requires ADB, USB debugging, and explicit
  authorization of the Mac on the phone; support depends on the phone's ROM.
  These settings are not enabled automatically.

The release package is not notarized with a paid Developer ID. If macOS blocks
the downloaded package, follow the project's
[installation instructions](https://github.com/jlikeme/HoRNDIS-Userspace#package-installer)
and approve it in **System Settings → Privacy & Security**.

See the [English guide](https://github.com/jlikeme/HoRNDIS-Userspace/blob/main/docs/USER_GUIDE.md)
or [中文使用手册](https://github.com/jlikeme/HoRNDIS-Userspace/blob/main/docs/USER_GUIDE.zh-CN.md).

### Updating the cask

Use the `horndis.rb` attached to a new enhanced HoRNDIS release as the source for
`Casks/horndis.rb`. It is generated from the actual package version, public
download URL and SHA-256 checksum. Keep the `--homebrew` uninstall argument so
reinstall/upgrade cleanup remains distinct from full uninstall.

## imsg

Homebrew tap for [`imsg`](https://github.com/jlikeme/imsg) — a macOS CLI to send,
read, and stream iMessage and SMS from the terminal.

### Install

```bash
brew install jlikeme/tap/imsg
```

Equivalent two-step form:

```bash
brew tap jlikeme/tap
brew install imsg
```

### Upgrade

```bash
brew update
brew upgrade jlikeme/tap/imsg
```

### Uninstall

```bash
brew uninstall jlikeme/tap/imsg
```

### Requirements

- macOS 14 (Sonoma) or newer
- Xcode 15+ command line tools (used to build the Swift binary)
- Full Disk Access for your terminal (to read `~/Library/Messages/chat.db`)
- Automation permission for your terminal to control Messages.app (for sending)

### Updating the formula

When `jlikeme/imsg` cuts a new tag (e.g. `v0.6.0`):

1. Update `tag:` and `revision:` in `Formula/imsg.rb`.
2. Bump the pinned tag/revision; the URL stays the same.
3. Open a PR; once merged, users get the new version on `brew upgrade`.

## Remove the tap

After uninstalling all packages you no longer need from this tap:

```sh
brew untap jlikeme/tap
```

