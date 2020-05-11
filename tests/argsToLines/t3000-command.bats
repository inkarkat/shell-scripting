#!/usr/bin/env bats

load marker

@test "command is not executed if no arguments are supplied" {
    run argsToLines --command "$TO_MARKER_COMMANDLINE"
    [ $status -eq 0 ]
    assert_no_marker
}

@test "command is executed once if two arguments are supplied" {
    run argsToLines --command "$TO_MARKER_COMMANDLINE" foo bar
    [ $status -eq 0 ]
    assert_marker_contents "foo
bar"
}
