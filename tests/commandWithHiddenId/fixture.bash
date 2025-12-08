#!/bin/bash

bats_require_minimum_version 1.5.0
bats_load_library bats-support
bats_load_library bats-assert

INPUT=("1 foo" "2 bar" "4 boo" "9 quux")
setup()
{
    local IFS=$'\n'
    INPUTSTRING="${INPUT[*]}"
}
commandWithInput()
{
    local IFS=$'\n'
    echo "${INPUT[*]}" | commandWithHiddenId "$@"
}
