#!/usr/bin/env bats

load fixture

@test "failing command returns 1 with --either-failure" {
    run -1 --separate-stderr succeedsOrRetryArg --either-failure "${EPOCH[@]}" "$BAD_EPOCH_INPUT"
    assert_output "$BAD_EPOCH_INPUT"
}

@test "failing command returns 99 with --either-failure" {
    run -99 --separate-stderr succeedsOrRetryArg --either-failure failNinetyNine arg
    assert_output 'arg'
}

@test "failing command returns 99 with --either-failure because retry command is also failing with 99" {
    run -99 --separate-stderr succeedsOrRetryArg --either-failure --retry-exec failNinetyNine \; "${EPOCH[@]}" arg
    assert_output ''
}

@test "failing command returns 1 with --either-failure because retry command is also failing with 1" {
    run -1 --separate-stderr succeedsOrRetryArg --either-failure --retry-exec "${EPOCH[@]}" \; failNinetyNine arg
    assert_output ''
}
