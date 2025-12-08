#!/usr/bin/env bats

load marker

@test "command is not executed if no arguments are supplied" {
    run -0 argsToLines --command "$TO_MARKER_COMMANDLINE"
    assert_no_marker
}

@test "command is executed once if two arguments are supplied" {
    run -0 argsToLines --command "$TO_MARKER_COMMANDLINE" foo bar
    assert_marker_contents "foo
bar"
}
