# homebrew-tap

Homebrew tap for [`imsg`](https://github.com/jlikeme/imsg) — a macOS CLI to send,
read, and stream iMessage and SMS from the terminal.

## Install

```bash
brew install jlikeme/tap/imsg
```

Equivalent two-step form:

```bash
brew tap jlikeme/tap
brew install imsg
```

## Upgrade

```bash
brew update
brew upgrade jlikeme/tap/imsg
```

## Uninstall

```bash
brew uninstall jlikeme/tap/imsg
brew untap jlikeme/tap
```

## Requirements

- macOS 14 (Sonoma) or newer
- Xcode 15+ command line tools (used to build the Swift binary)
- Full Disk Access for your terminal (to read `~/Library/Messages/chat.db`)
- Automation permission for your terminal to control Messages.app (for sending)

## Updating the formula

When `jlikeme/imsg` cuts a new tag (e.g. `v0.6.0`):

1. Update `tag:` and `revision:` in `Formula/imsg.rb`.
2. Bump the pinned tag/revision; the URL stays the same.
3. Open a PR; once merged, users get the new version on `brew upgrade`.
