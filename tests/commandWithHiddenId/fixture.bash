#!/bin/bash

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
