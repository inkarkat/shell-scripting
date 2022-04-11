#!/usr/bin/env bats

load fixture

@test "failing command returns 1 with --either-failure" {
    runStdout succeedsOrRetryArg --either-failure "${EPOCH[@]}" "$BAD_EPOCH_INPUT"
    [ $status -eq 1 ]
    [ "$output" = "$BAD_EPOCH_INPUT" ]
}

@test "failing command returns 99 with --either-failure" {
    runStdout succeedsOrRetryArg --either-failure failNinetyNine arg
    [ $status -eq 99 ]
    [ "$output" = "arg" ]
}

@test "failing command returns 99 with --either-failure because retry command is also failing with 99" {
    runStdout succeedsOrRetryArg --either-failure --retry-exec failNinetyNine \; "${EPOCH[@]}" arg
    [ $status -eq 99 ]
    [ "$output" = "" ]
}

@test "failing command returns 1 with --either-failure because retry command is also failing with 1" {
    runStdout succeedsOrRetryArg --either-failure --retry-exec "${EPOCH[@]}" \; failNinetyNine arg
    [ $status -eq 1 ]
    [ "$output" = "" ]
}
