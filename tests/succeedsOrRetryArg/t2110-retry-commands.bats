#!/usr/bin/env bats

load fixture

@test "retry command-line and exec command with arg placeholders" {
    run -0 succeedsOrRetryArg --retry-command "${BRACE_PLACEHOLDER[*]}" --retry-exec "${EPOCH[@]}" \; failNinetyNine "$GOOD_EPOCH_INPUT"
    assert_output "[${GOOD_EPOCH_INPUT}]$GOOD_EPOCH_RESULT"
}

@test "retry command-lines with arg placeholders" {
    run -0 succeedsOrRetryArg --retry-command "${BRACE_PLACEHOLDER[*]}" --retry-command "${EPOCH[*]}" failNinetyNine "$GOOD_EPOCH_INPUT"
    assert_output "[${GOOD_EPOCH_INPUT}]$GOOD_EPOCH_RESULT"
}

@test "retry exec commands with arg placeholders" {
    run -0 succeedsOrRetryArg --retry-exec "${BRACE_PLACEHOLDER[@]}" \; --retry-exec "${EPOCH[@]}" \; failNinetyNine "$GOOD_EPOCH_INPUT"
    assert_output "[${GOOD_EPOCH_INPUT}]$GOOD_EPOCH_RESULT"
}
