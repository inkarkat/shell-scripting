#!/usr/bin/env bats

load fixture

@test "failing command returns 1 with --first-failure" {
    runStdout succeedsOrRetryArg --first-failure "${EPOCH[@]}" "$BAD_EPOCH_INPUT"
    [ $status -eq 1 ]
    [ "$output" = "$BAD_EPOCH_INPUT" ]
}

@test "failing command returns 99 with --first-failure" {
    runStdout succeedsOrRetryArg --first-failure failNinetyNine arg
    [ $status -eq 99 ]
    [ "$output" = "arg" ]
}

@test "failing command returns 1 with --first-failure despite retry command also failing with 99" {
    runStdout succeedsOrRetryArg --first-failure --retry-exec failNinetyNine \; "${EPOCH[@]}" arg
    [ $status -eq 1 ]
    [ "$output" = "" ]
}
