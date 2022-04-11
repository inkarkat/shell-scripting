#!/usr/bin/env bats

load fixture

@test "successful simple command does not invoke retry" {
    run succeedsOrRetryArg --retry-command "${BRACE_APPENDED[*]}" "${EPOCH[@]}" "$GOOD_EPOCH_INPUT"
    [ $status -eq 0 ]
    [ "$output" = "$GOOD_EPOCH_RESULT" ]
}

@test "failing command retries with exec command appended" {
    runStdout succeedsOrRetryArg --retry-exec "${BRACE_APPENDED[@]}" \; "${EPOCH[@]}" "$BAD_EPOCH_INPUT"
    [ $status -eq 0 ]
    [ "$output" = "[${BAD_EPOCH_INPUT}]" ]
}

@test "failing command retries with command-line appended" {
    runStdout succeedsOrRetryArg --retry-command "${BRACE_APPENDED[*]}" "${EPOCH[@]}" "$BAD_EPOCH_INPUT"
    [ $status -eq 0 ]
    [ "$output" = "[${BAD_EPOCH_INPUT}]" ]
}

@test "failing command retries with exec command placeholder" {
    runStdout succeedsOrRetryArg --retry-exec "${BRACE_PLACEHOLDER[@]}" \; "${EPOCH[@]}" "$BAD_EPOCH_INPUT"
    [ $status -eq 0 ]
    [ "$output" = "[${BAD_EPOCH_INPUT}]" ]
}

@test "failing command retries with command-line placeholder" {
    runStdout succeedsOrRetryArg --retry-command "${BRACE_PLACEHOLDER[*]}" "${EPOCH[@]}" "$BAD_EPOCH_INPUT"
    [ $status -eq 0 ]
    [ "$output" = "[${BAD_EPOCH_INPUT}]" ]
}
