#!/usr/bin/env bash
set -euo pipefail

ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
TMP_DIR="$(mktemp -d)"
trap 'rm -rf "$TMP_DIR"' EXIT

git -C "$ROOT" fetch upstream main
git -C "$ROOT" archive --format=tar upstream/main | tar -xf - -C "$TMP_DIR"
python3 "$ROOT/tools/convert_gstack.py" --source-dir "$TMP_DIR" --dest-dir "$ROOT"
git -C "$ROOT" rev-parse upstream/main > "$ROOT/UPSTREAM_COMMIT"
"$ROOT/scripts/validate.sh"
