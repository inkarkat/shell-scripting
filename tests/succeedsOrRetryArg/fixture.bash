#!/bin/bash

bats_require_minimum_version 1.5.0
bats_load_library bats-support
bats_load_library bats-assert

export LC_ALL=C TZ=Etc/UTC
export EPOCH=(date --date {} +%s)
export BRACE_PLACEHOLDER=(printf %s%s%s \[ {} \])
export BRACE_APPENDED=(printf [%s])
export GOOD_EPOCH_INPUT='20-Apr-2022'
export GOOD_EPOCH_RESULT='1650412800'
export BAD_EPOCH_INPUT='no valid date'

failNinetyNine()
{
    (exit 99)
}
export -f failNinetyNine
