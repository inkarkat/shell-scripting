#!/usr/bin/env bats

load fixture

@test "successful simple command does not invoke retry" {
    run -0 succeedsOrRetryArg --retry-command "${BRACE_APPENDED[*]}" "${EPOCH[@]}" "$GOOD_EPOCH_INPUT"
    assert_output "$GOOD_EPOCH_RESULT"
}

@test "failing command retries with exec command appended" {
    run -0 --separate-stderr succeedsOrRetryArg --retry-exec "${BRACE_APPENDED[@]}" \; "${EPOCH[@]}" "$BAD_EPOCH_INPUT"
    assert_output "[${BAD_EPOCH_INPUT}]"
}

@test "failing command retries with command-line appended" {
    run -0 --separate-stderr succeedsOrRetryArg --retry-command "${BRACE_APPENDED[*]}" "${EPOCH[@]}" "$BAD_EPOCH_INPUT"
    assert_output "[${BAD_EPOCH_INPUT}]"
}

@test "failing command retries with exec command placeholder" {
    run -0 --separate-stderr succeedsOrRetryArg --retry-exec "${BRACE_PLACEHOLDER[@]}" \; "${EPOCH[@]}" "$BAD_EPOCH_INPUT"
    assert_output "[${BAD_EPOCH_INPUT}]"
}

@test "failing command retries with command-line placeholder" {
    run -0 --separate-stderr succeedsOrRetryArg --retry-command "${BRACE_PLACEHOLDER[*]}" "${EPOCH[@]}" "$BAD_EPOCH_INPUT"
    assert_output "[${BAD_EPOCH_INPUT}]"
}
