#!/usr/bin/env bats

load fixture

@test "empty file prints nothing once" {
    runWithFullOutput -0 dishOutSections --lines "${BATS_TEST_DIRNAME}/empty.txt"
    assert_output ''

    runWithFullOutput -4 dishOutSections --lines "${BATS_TEST_DIRNAME}/empty.txt"
    assert_output ''
}
