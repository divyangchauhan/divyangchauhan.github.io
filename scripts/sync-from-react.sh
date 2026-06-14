#!/usr/bin/env bash
set -euo pipefail

TARGET_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
SOURCE_DIR="${SOURCE_DIR:-$TARGET_DIR/../divyang.dev}"
DIST_DIR="$SOURCE_DIR/dist"

if [[ ! -d "$SOURCE_DIR" ]]; then
  echo "Source repo not found: $SOURCE_DIR" >&2
  echo "Set SOURCE_DIR=/path/to/personal-website-react if it moved." >&2
  exit 1
fi

if [[ ! -f "$SOURCE_DIR/package.json" ]]; then
  echo "Source repo does not look like a Node/Vite project: $SOURCE_DIR" >&2
  exit 1
fi

echo "Building $SOURCE_DIR"
if command -v pnpm >/dev/null 2>&1; then
  (cd "$SOURCE_DIR" && pnpm build)
elif command -v npm >/dev/null 2>&1; then
  (cd "$SOURCE_DIR" && npm run build)
else
  echo "Neither pnpm nor npm is available." >&2
  exit 1
fi

if [[ ! -f "$DIST_DIR/index.html" ]]; then
  echo "Build did not produce $DIST_DIR/index.html" >&2
  exit 1
fi

echo "Syncing built site into $TARGET_DIR"
rsync -a --delete \
  --exclude='.git/' \
  --exclude='scripts/' \
  --exclude='README.md' \
  "$DIST_DIR/" "$TARGET_DIR/"

touch "$TARGET_DIR/.nojekyll"
cp "$TARGET_DIR/index.html" "$TARGET_DIR/404.html"
mkdir -p "$TARGET_DIR/resume"
cp "$TARGET_DIR/index.html" "$TARGET_DIR/resume/index.html"

echo "Done. Review with: git -C \"$TARGET_DIR\" status --short"
