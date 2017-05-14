#!/usr/bin/env mksh
#
#
set -u -e -o pipefail
THE_ARGS="$@"

BIN="$1"

local +x EXPECTED="!FAILED"
local +x ACTUAL="$( "$BIN"  '"a"'  'a.b.c[0]' &>/dev/null || echo "!FAILED")"

if [[ "$EXPECTED" == "$ACTUAL" ]]; then
  sh_color GREEN "=== {{Passed}}: $EXPECTED == $ACTUAL"
else
  sh_color RED "$ACTUAL != $EXPECTED"
  exit 1
fi

