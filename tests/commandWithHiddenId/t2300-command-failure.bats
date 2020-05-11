#!/usr/bin/env bats

load fixture

@test "a failing command returns its exit status and outputs nothing" {
    run commandWithHiddenId --piped --command 'grep doesNotExist' -- "${INPUT[@]}"
    [ $status -eq 1 ]
    [ "$output" = "" ]
}

@test "a failing command returns its special exit status and its output" {
    run commandWithHiddenId --piped --command '(echo >&2 This is bad; exit 42)' -- "${INPUT[@]}"
    [ $status -eq 42 ]
    [ "$output" = "This is bad" ]
}
