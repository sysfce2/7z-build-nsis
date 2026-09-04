#!/usr/bin/env bash

set -euo pipefail

project_root=$(CDPATH='' cd -- "$(dirname -- "$0")/.." && pwd)
sevenzip=${1:-$project_root/dist/7zz}

if [[ ! -x $sevenzip ]]; then
  echo "error: 7zz binary not found or not executable: $sevenzip" >&2
  exit 1
fi
if ! command -v makensis >/dev/null 2>&1; then
  echo "error: makensis is required for the smoke test" >&2
  exit 1
fi

test_dir=$(mktemp -d "${TMPDIR:-/tmp}/7z-nsis-test.XXXXXX")
trap 'rm -rf "$test_dir"' EXIT

sed "s|@OUTFILE@|$test_dir/fixture.exe|" >"$test_dir/fixture.nsi" <<'EOF'
Name "7zz NSIS decompiler smoke test"
OutFile "@OUTFILE@"
SilentInstall silent
Section
  DetailPrint "NSIS script decompilation works"
SectionEnd
EOF

makensis -V2 "$test_dir/fixture.nsi"
mkdir -p "$test_dir/extracted"
"$sevenzip" e -y "-o$test_dir/extracted" "$test_dir/fixture.exe" '[NSIS].nsi' >/dev/null

if [[ ! -s $test_dir/extracted/'[NSIS].nsi' ]]; then
  echo "error: [NSIS].nsi was not extracted" >&2
  exit 1
fi

echo "NSIS decompilation smoke test passed"
