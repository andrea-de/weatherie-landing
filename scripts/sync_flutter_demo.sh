#!/usr/bin/env bash

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
LANDING_DIR="$(cd "$SCRIPT_DIR/.." && pwd)"
FLUTTER_DIR="$(cd "$LANDING_DIR/../flutter" && pwd)"

"$FLUTTER_DIR/scripts/build_demo_web.sh" --base-href /demo/
rsync -a --delete "$FLUTTER_DIR/build/web/" "$LANDING_DIR/public/demo/"
