#!/usr/bin/env bats

load fixture

@test "empty file prints nothing once" {
    runWithFullOutput -0 dishOutSections --blocks 2 "${BATS_TEST_DIRNAME}/empty.txt"
    assert_output ''

    runWithFullOutput -4 dishOutSections --blocks 2 "${BATS_TEST_DIRNAME}/empty.txt"
    assert_output ''
}
