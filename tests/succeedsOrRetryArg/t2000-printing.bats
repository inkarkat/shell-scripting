#!/usr/bin/env bats

load fixture

@test "successful simple command with arg appended" {
    run -0 succeedsOrRetryArg "${BRACE_APPENDED[@]}" "$GOOD_EPOCH_INPUT"
    assert_output "[${GOOD_EPOCH_INPUT}]"
}

@test "successful exec command with arg appended" {
    run -0 succeedsOrRetryArg --exec "${BRACE_APPENDED[@]}" \; "$GOOD_EPOCH_INPUT"
    assert_output "[${GOOD_EPOCH_INPUT}]"
}

@test "successful command-line with arg appended" {
    run -0 succeedsOrRetryArg --command "${BRACE_APPENDED[*]}" "$GOOD_EPOCH_INPUT"
    assert_output "[${GOOD_EPOCH_INPUT}]"
}


@test "successful simple command with arg placeholder" {
    run -0 succeedsOrRetryArg "${EPOCH[@]}" "$GOOD_EPOCH_INPUT"
    assert_output "$GOOD_EPOCH_RESULT"
}

@test "successful exec command with arg placeholder" {
    run -0 succeedsOrRetryArg --exec "${EPOCH[@]}" \; "$GOOD_EPOCH_INPUT"
    assert_output "$GOOD_EPOCH_RESULT"
}

@test "successful command-line with arg placeholder" {
    run -0 succeedsOrRetryArg --command "${EPOCH[*]}" "$GOOD_EPOCH_INPUT"
    assert_output "$GOOD_EPOCH_RESULT"
}


@test "failing simple command prints arg" {
    run -0 --separate-stderr succeedsOrRetryArg "${EPOCH[@]}" "$BAD_EPOCH_INPUT"
    assert_output "$BAD_EPOCH_INPUT"
}

@test "failing exec command prints arg" {
    run -0 --separate-stderr succeedsOrRetryArg --exec "${EPOCH[@]}" \; "$BAD_EPOCH_INPUT"
    assert_output "$BAD_EPOCH_INPUT"
}

@test "failing command-line prints arg" {
    run -0 --separate-stderr succeedsOrRetryArg --command "${EPOCH[*]}" "$BAD_EPOCH_INPUT"
    assert_output "$BAD_EPOCH_INPUT"
}
