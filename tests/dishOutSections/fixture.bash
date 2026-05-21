#!/bin/bash

bats_require_minimum_version 1.5.0
bats_load_library bats-support
bats_load_library bats-assert

export XDG_DATA_HOME="$BATS_TMPDIR"

readonly SECTION_NUM=6
readonly LINE_NUM=12

fixtureSetup()
{
    rm -rf -- "${BATS_TMPDIR:?}/dishOutSections"
}
setup()
{
    fixtureSetup
}

runneeWrapper()
{
    "$@"
    local status=$?
    printf '$'
    return $status
}
runWithFullOutput()
{
    typeset -a runArg=()
    if [ "$1" = '!' ] || [[ "$1" =~ ^-[0-9]+$ ]]; then
	runArg=("$1"); shift
    fi

    run "${runArg[@]}" runneeWrapper "$@"
    output="${output%\$}"
}
