#!/usr/bin/env bats

load fixture

@test "a failing command returns its exit status and outputs nothing" {
    run -1 commandWithHiddenId --piped --command 'grep doesNotExist' -- "${INPUT[@]}"
    assert_output ''
}

@test "a failing command returns its special exit status and its output" {
    run -42 commandWithHiddenId --piped --command '(echo >&2 This is bad; exit 42)' -- "${INPUT[@]}"
    assert_output 'This is bad'
}
