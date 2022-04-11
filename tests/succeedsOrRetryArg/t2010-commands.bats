#!/usr/bin/env bats

load fixture

@test "successful command-line and simple command with arg placeholders" {
    run succeedsOrRetryArg --command "${BRACE_PLACEHOLDER[*]}" "${EPOCH[@]}" "$GOOD_EPOCH_INPUT"
    [ $status -eq 0 ]
    [ "$output" = "[${GOOD_EPOCH_INPUT}]$GOOD_EPOCH_RESULT" ]
}

@test "successful exec command and simple command with arg placeholders" {
    run succeedsOrRetryArg --exec "${BRACE_PLACEHOLDER[@]}" \; "${EPOCH[@]}" "$GOOD_EPOCH_INPUT"
    [ $status -eq 0 ]
    [ "$output" = "[${GOOD_EPOCH_INPUT}]$GOOD_EPOCH_RESULT" ]
}

@test "successful command-line and exec command with arg placeholders" {
    run succeedsOrRetryArg --command "${BRACE_PLACEHOLDER[*]}" --exec "${EPOCH[@]}" \; "$GOOD_EPOCH_INPUT"
    [ $status -eq 0 ]
    [ "$output" = "[${GOOD_EPOCH_INPUT}]$GOOD_EPOCH_RESULT" ]
}

@test "successful command-lines with arg placeholders" {
    run succeedsOrRetryArg --command "${BRACE_PLACEHOLDER[*]}" --command "${EPOCH[*]}" "$GOOD_EPOCH_INPUT"
    [ $status -eq 0 ]
    [ "$output" = "[${GOOD_EPOCH_INPUT}]$GOOD_EPOCH_RESULT" ]
}

@test "successful exec commands with arg placeholders" {
    run succeedsOrRetryArg --exec "${BRACE_PLACEHOLDER[@]}" \; --exec "${EPOCH[@]}" \; "$GOOD_EPOCH_INPUT"
    [ $status -eq 0 ]
    [ "$output" = "[${GOOD_EPOCH_INPUT}]$GOOD_EPOCH_RESULT" ]
}

@test "successful exec command, command-line, and simple command with arg placeholders" {
    run succeedsOrRetryArg --exec "${BRACE_PLACEHOLDER[@]}" \; --command "${BRACE_PLACEHOLDER[*]}" "${EPOCH[@]}" "$GOOD_EPOCH_INPUT"
    [ $status -eq 0 ]
    [ "$output" = "[${GOOD_EPOCH_INPUT}][${GOOD_EPOCH_INPUT}]$GOOD_EPOCH_RESULT" ]
}
