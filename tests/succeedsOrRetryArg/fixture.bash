#!/bin/bash

export EPOCH=(date --date {} +%s)
export BRACE_PLACEHOLDER=(printf %s%s%s \[ {} \])
export BRACE_APPENDED=(printf [%s])
export GOOD_EPOCH_INPUT='20-Apr-2022'
export GOOD_EPOCH_RESULT='1650405600'
export BAD_EPOCH_INPUT='no valid date'

runStdout() {
  local origFlags="$-"
  set +eET
  local origIFS="$IFS"
  output="$("$@" 2>/dev/null)"
  status="$?"
  IFS=$'\n' lines=($output)
  IFS="$origIFS"
  set "-$origFlags"
}

failNinetyNine()
{
    (exit 99)
}
export -f failNinetyNine
