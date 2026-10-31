#!/usr/bin/env bash
# Mirror the latest Oriel release into the Homebrew cask.
#
# Usage:
#   ./scripts/update-cask.sh          # use the latest stable release
#   ./scripts/update-cask.sh v1.0.1   # mirror a specific tag
set -euo pipefail

ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
CASK="${ORIEL_CASK:-$ROOT/Casks/oriel.rb}"
REPO="${ORIEL_REPO:-Irfanwani/oriel}"
TAG="${1:-${ORIEL_TAG:-}}"

if [[ ! -f "$CASK" ]]; then
  echo "Cask not found: $CASK" >&2
  exit 1
fi

if [[ -z "$TAG" ]]; then
  RELEASE_URL="$(curl -fsSIL -o /dev/null -w '%{url_effective}' \
    "https://github.com/$REPO/releases/latest")"
  TAG="${RELEASE_URL##*\/tag\/}"
fi

case "$TAG" in
  v*) ;;
  *) TAG="v$TAG" ;;
esac

VERSION="${TAG#v}"
if [[ ! "$VERSION" =~ ^[0-9]+\.[0-9]+\.[0-9]+([.-][0-9A-Za-z.-]+)?$ ]]; then
  echo "Unexpected version from tag: $TAG" >&2
  exit 1
fi

ASSET="Oriel-${VERSION}.dmg"
BASE_URL="https://github.com/$REPO/releases/download/$TAG"
TMP_DIR="$(mktemp -d)"
trap 'rm -rf "$TMP_DIR"' EXIT

SHA_FILE="${ASSET}.sha256"
if ! curl -fsSL "$BASE_URL/$SHA_FILE" -o "$TMP_DIR/$SHA_FILE"; then
  echo "Could not download checksum: $BASE_URL/$SHA_FILE" >&2
  exit 1
fi

read -r SHA DOWNLOADED_ASSET < "$TMP_DIR/$SHA_FILE"
if [[ ! "$SHA" =~ ^[0-9a-f]{64}$ ]]; then
  echo "Invalid SHA256 in $SHA_FILE: $SHA" >&2
  exit 1
fi
if [[ "$DOWNLOADED_ASSET" != "$ASSET" ]]; then
  echo "Checksum is for $DOWNLOADED_ASSET, expected $ASSET" >&2
  exit 1
fi

CURRENT_VERSION="$(sed -n 's/^  version "\(.*\)"$/\1/p' "$CASK")"
CURRENT_SHA="$(sed -n 's/^  sha256 "\([0-9a-f]*\)"$/\1/p' "$CASK")"

if [[ "$CURRENT_VERSION" == "$VERSION" && "$CURRENT_SHA" == "$SHA" ]]; then
  echo "Cask is already at $VERSION ($SHA)"
  exit 0
fi

sed -i.bak \
  -e "s/^  version \".*\"$/  version \"$VERSION\"/" \
  -e "s/^  sha256 \"[0-9a-f]*\"$/  sha256 \"$SHA\"/" \
  "$CASK"
rm -f "${CASK}.bak"

echo "Updated cask from ${CURRENT_VERSION:-unknown} to $VERSION"
echo "  sha256 $SHA"
