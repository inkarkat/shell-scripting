#!/usr/bin/env bats

load fixture

@test "failing command returns 1 with --first-failure" {
    run -1 --separate-stderr succeedsOrRetryArg --first-failure "${EPOCH[@]}" "$BAD_EPOCH_INPUT"
    assert_output "$BAD_EPOCH_INPUT"
}

@test "failing command returns 99 with --first-failure" {
    run -99 --separate-stderr succeedsOrRetryArg --first-failure failNinetyNine arg
    assert_output 'arg'
}

@test "failing command returns 1 with --first-failure despite retry command also failing with 99" {
    run -1 --separate-stderr succeedsOrRetryArg --first-failure --retry-exec failNinetyNine \; "${EPOCH[@]}" arg
    assert_output ''
}
