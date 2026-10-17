#!/bin/bash
# Build the engine for Shuffle Studio's Go Deeper page and copy the files it
# serves into one folder named after this commit.
#
#   ./scripts/go-deeper.sh [out-dir]     (default: dist/go-deeper)
#
# Output: <out-dir>/<commit>/websockets-doom.js, websockets-doom.wasm, VERSION
# The site copies that folder to public/go-deeper/engine/<commit>/.

set -euo pipefail

cd "$(dirname "$0")/.."

if ! git diff --quiet HEAD; then
    echo "Commit your changes first: VERSION must name the source that was built." >&2
    exit 1
fi

COMMIT=$(git rev-parse --short=12 HEAD)
OUT="${1:-dist/go-deeper}/$COMMIT"

./scripts/clean.sh || true
./scripts/build.sh

mkdir -p "$OUT"
cp src/websockets-doom.js src/websockets-doom.wasm "$OUT/"
cat > "$OUT/VERSION" <<EOF
source: https://github.com/shuffle-studio/doom-wasm/tree/$(git rev-parse HEAD)
license: GPL-2.0 (see COPYING in the source)
built: $(date -u +%Y-%m-%dT%H:%M:%SZ) with $(emcc --version | head -1)
EOF

ls -l "$OUT"
