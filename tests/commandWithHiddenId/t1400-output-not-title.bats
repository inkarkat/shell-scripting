#!/usr/bin/env bats

load fixture

@test "returns 126 and error message if COMMANDLINE outputs no titles" {
    run commandWithHiddenId --piped --command 'sed -e s/^/x/' -- "${INPUT[@]}"
    [ $status -eq 126 ]
    [ "$output" = "ERROR: This COMMANDLINE output is not a TITLE: xfoo" ]
}

@test "returns 126 and error message if COMMANDLINE outputs some non-title" {
    run commandWithHiddenId --piped --command 'sed -e s/boo/notATitle/' -- "${INPUT[@]}"
    [ $status -eq 126 ]
    [ "$output" = "ERROR: This COMMANDLINE output is not a TITLE: notATitle" ]
}
