# Homebrew Tap for Oriel

[![Test cask](https://github.com/Irfanwani/homebrew-oriel/actions/workflows/test.yml/badge.svg)](https://github.com/Irfanwani/homebrew-oriel/actions/workflows/test.yml)
[![Update cask](https://github.com/Irfanwani/homebrew-oriel/actions/workflows/update-cask.yml/badge.svg)](https://github.com/Irfanwani/homebrew-oriel/actions/workflows/update-cask.yml)

[A calmer desktop for macOS.](https://github.com/Irfanwani/oriel)

## Install

```sh
brew install --cask irfanwani/oriel/oriel
```

This installs **Oriel.app** into `/Applications` and the **`oriel`** command into
Homebrew's bin directory.

## Updates

The cask is normally updated automatically from the latest [Oriel release](https://github.com/Irfanwani/oriel/releases). The updater runs hourly, can be dispatched instantly by the release workflow, and audits + installs the updated cask before committing. `brew upgrade --cask oriel` installs the new version once it is available.

Maintainers can also run the **Update cask** workflow manually from the Actions tab. See the [release guide](https://github.com/Irfanwani/oriel/blob/main/RELEASING.md) for the optional `TAP_TOKEN` setup.

## Upgrade

```sh
brew upgrade --cask oriel
```

Oriel is ad-hoc signed rather than notarized. macOS may ask you to approve it on
first launch, and updates may require toggling Accessibility access off and on
again because the signature changes.

## Uninstall

```sh
brew uninstall --cask oriel
```

To remove local settings and scenes as well:

```sh
brew uninstall --zap --cask oriel
```

## Links

- [Oriel source](https://github.com/Irfanwani/oriel)
- [Website](https://irfanwani.github.io/oriel/)
- [Releases](https://github.com/Irfanwani/oriel/releases)
- [Issues](https://github.com/Irfanwani/oriel/issues)

Licensed under the [MIT License](https://github.com/Irfanwani/oriel/blob/main/LICENSE).
