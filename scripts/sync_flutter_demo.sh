#!/usr/bin/env bash

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
LANDING_DIR="$(cd "$SCRIPT_DIR/.." && pwd)"
# The Flutter app repo (andrea-de/weatherie), checked out beside this one.
# Override with APP_DIR=... if your checkout lives elsewhere.
FLUTTER_DIR="$(cd "${APP_DIR:-$LANDING_DIR/../weatherie}" 2>/dev/null && pwd || true)"

if [[ -z "$FLUTTER_DIR" || ! -f "$FLUTTER_DIR/scripts/build_demo_web.sh" ]]; then
  echo "Flutter app repo not found (looked for ${APP_DIR:-$LANDING_DIR/../weatherie})." >&2
  echo "Clone andrea-de/weatherie beside this repo, or set APP_DIR." >&2
  exit 1
fi

bash "$FLUTTER_DIR/scripts/build_demo_web.sh" --base-href /demo/
rsync -a --delete "$FLUTTER_DIR/build/web/" "$LANDING_DIR/public/demo/"
