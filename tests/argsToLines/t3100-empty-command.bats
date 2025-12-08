#!/usr/bin/env bats

load marker

@test "empty-command is executed without piping if no arguments are supplied" {
    run -0 argsToLines --empty-command true
    assert_no_marker
}

@test "empty-command is executed if no arguments are supplied" {
    run -0 argsToLines --empty-command "echo default | $TO_MARKER_COMMANDLINE"
    assert_marker_contents "default"
}

@test "command with --command-takes-empty is executed and piped to if no arguments are supplied" {
    run -0 argsToLines --command "$TO_MARKER_COMMANDLINE" --command-takes-empty
    assert_marker_contents ""
}

@test "combine --command with --empty-command invokes --command with arguments" {
    run -0 argsToLines --command "$TO_MARKER_COMMANDLINE" --empty-command "echo default | $TO_MARKER_COMMANDLINE" -- foo bar
    assert_marker_contents "foo
bar"
}

@test "combine --command with --empty-command invokes --empty-command without arguments" {
    run -0 argsToLines --command "$TO_MARKER_COMMANDLINE" --empty-command "echo default | $TO_MARKER_COMMANDLINE" --
    assert_marker_contents "default"
}

@test "cannot compbine --command-takes-empty with --empty-command" {
    run -2 argsToLines --command true --command-takes-empty --empty-command true
    assert_line -n 0 -e ^Usage:
}

@test "can pass --command-takes-empty without --command" {
    run -0 argsToLines --command-takes-empty
}
