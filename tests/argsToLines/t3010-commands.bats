#!/usr/bin/env bats

load marker

@test "multiple commands are executed as a pipeline if two arguments are supplied" {
    run argsToLines --command 'tr a-z A-Z' --command "$TO_MARKER_COMMANDLINE" foo bar
    [ $status -eq 0 ]
    assert_marker_contents "FOO
BAR"
}
