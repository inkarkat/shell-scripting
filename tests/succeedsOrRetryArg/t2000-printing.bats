#!/usr/bin/env bats

load fixture

@test "successful simple command with arg appended" {
    run succeedsOrRetryArg "${BRACE_APPENDED[@]}" "$GOOD_EPOCH_INPUT"
    [ $status -eq 0 ]
    [ "$output" = "[${GOOD_EPOCH_INPUT}]" ]
}

@test "successful exec command with arg appended" {
    run succeedsOrRetryArg --exec "${BRACE_APPENDED[@]}" \; "$GOOD_EPOCH_INPUT"
    [ $status -eq 0 ]
    [ "$output" = "[${GOOD_EPOCH_INPUT}]" ]
}

@test "successful command-line with arg appended" {
    run succeedsOrRetryArg --command "${BRACE_APPENDED[*]}" "$GOOD_EPOCH_INPUT"
    [ $status -eq 0 ]
    [ "$output" = "[${GOOD_EPOCH_INPUT}]" ]
}


@test "successful simple command with arg placeholder" {
    run succeedsOrRetryArg "${EPOCH[@]}" "$GOOD_EPOCH_INPUT"
    [ $status -eq 0 ]
    [ "$output" = "$GOOD_EPOCH_RESULT" ]
}

@test "successful exec command with arg placeholder" {
    run succeedsOrRetryArg --exec "${EPOCH[@]}" \; "$GOOD_EPOCH_INPUT"
    [ $status -eq 0 ]
    [ "$output" = "$GOOD_EPOCH_RESULT" ]
}

@test "successful command-line with arg placeholder" {
    run succeedsOrRetryArg --command "${EPOCH[*]}" "$GOOD_EPOCH_INPUT"
    [ $status -eq 0 ]
    [ "$output" = "$GOOD_EPOCH_RESULT" ]
}


@test "failing simple command prints arg" {
    runStdout succeedsOrRetryArg "${EPOCH[@]}" "$BAD_EPOCH_INPUT"
    [ $status -eq 0 ]
    [ "$output" = "$BAD_EPOCH_INPUT" ]
}

@test "failing exec command prints arg" {
    runStdout succeedsOrRetryArg --exec "${EPOCH[@]}" \; "$BAD_EPOCH_INPUT"
    [ $status -eq 0 ]
    [ "$output" = "$BAD_EPOCH_INPUT" ]
}

@test "failing command-line prints arg" {
    runStdout succeedsOrRetryArg --command "${EPOCH[*]}" "$BAD_EPOCH_INPUT"
    [ $status -eq 0 ]
    [ "$output" = "$BAD_EPOCH_INPUT" ]
}
