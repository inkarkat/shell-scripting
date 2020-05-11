#!/usr/bin/env bats

load marker

@test "empty-command is executed without piping if no arguments are supplied" {
    run argsToLines --empty-command true
    [ $status -eq 0 ]
    assert_no_marker
}

@test "empty-command is executed if no arguments are supplied" {
    run argsToLines --empty-command "echo default | $TO_MARKER_COMMANDLINE"
    [ $status -eq 0 ]
    assert_marker_contents "default"
}

@test "command with --command-takes-empty is executed and piped to if no arguments are supplied" {
    run argsToLines --command "$TO_MARKER_COMMANDLINE" --command-takes-empty
    [ $status -eq 0 ]
    assert_marker_contents ""
}

@test "combine --command with --empty-command invokes --command with arguments" {
    run argsToLines --command "$TO_MARKER_COMMANDLINE" --empty-command "echo default | $TO_MARKER_COMMANDLINE" -- foo bar
    [ $status -eq 0 ]
    assert_marker_contents "foo
bar"
}

@test "combine --command with --empty-command invokes --empty-command without arguments" {
    run argsToLines --command "$TO_MARKER_COMMANDLINE" --empty-command "echo default | $TO_MARKER_COMMANDLINE" --
    [ $status -eq 0 ]
    assert_marker_contents "default"
}

@test "cannot compbine --command-takes-empty with --empty-command" {
    run argsToLines --command true --command-takes-empty --empty-command true
    [ $status -eq 2 ]
    [[ "${lines[0]}" =~ ^Usage: ]]
}

@test "can pass --command-takes-empty without --command" {
    run argsToLines --command-takes-empty
    [ $status -eq 0 ]
}
