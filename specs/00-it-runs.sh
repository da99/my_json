#!/usr/bin/env mksh
#
#
set -u -e -o pipefail
THE_ARGS="$@"

BIN="$1"

local +x EXPECTED="1"
local +x ACTUAL="$( "$BIN"  '{"a":{"b":{"c":[1,2,3]}}}'  'a.b.c[0]' )"

if [[ "$EXPECTED" == "$ACTUAL" ]]; then
  sh_color GREEN "=== {{Passed}}: $EXPECTED == $ACTUAL"
  return 0
else
  sh_color RED "$ACTUAL != $EXPECTED"
  exit 1
fi
