#!/bin/sh

set -eu

source_dir=${1:-.}
nsis_header="$source_dir/CPP/7zip/Archive/Nsis/NsisIn.h"

if [ ! -f "$nsis_header" ]; then
  echo "error: 7-Zip NSIS header not found: $nsis_header" >&2
  exit 1
fi

if ! grep -Eq '^[[:space:]]*#define[[:space:]]+NSIS_SCRIPT([[:space:]]|$)' "$nsis_header"; then
  sed -i 's|^[[:space:]]*//[[:space:]]*#define[[:space:]]*NSIS_SCRIPT[[:space:]]*$|#define NSIS_SCRIPT|' "$nsis_header"
fi

if ! grep -Eq '^[[:space:]]*#define[[:space:]]+NSIS_SCRIPT([[:space:]]|$)' "$nsis_header"; then
  echo "error: unable to enable NSIS_SCRIPT in $nsis_header" >&2
  exit 1
fi
