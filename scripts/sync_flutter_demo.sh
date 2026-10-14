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

# REMOVE_LOCAL_ENGINE=1 drops build/web/canvaskit/ (~28 MB of renderer wasm).
# It is dead weight here: the Flutter loader resolves its renderer from
# https://www.gstatic.com/flutter-canvaskit/<engineRevision>/ unless the build
# passes --local-web-sdk-canvaskit, which ours does not — so the bundled copy
# is never requested. Verified by tracing the demo's network activity: the only
# renderer fetches go to gstatic. Keeping it would commit 28 MB to a public
# repo for nothing, and this repo's size is already a concern.
REMOVE_LOCAL_ENGINE=1 bash "$FLUTTER_DIR/scripts/build_demo_web.sh" --base-href /demo/
rsync -a --delete "$FLUTTER_DIR/build/web/" "$LANDING_DIR/public/demo/"
