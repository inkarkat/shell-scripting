#!/usr/bin/env bats

load fixture

@test "empty file prints one empty section" {
    runWithFullOutput -0 dishOutSections "${BATS_TEST_DIRNAME}/empty.txt"
    assert_output ''

    runWithFullOutput -4 dishOutSections "${BATS_TEST_DIRNAME}/empty.txt"
    assert_output ''
}

@test "file with just one separator prints two empty sections" {
    runWithFullOutput -0 dishOutSections "${BATS_TEST_DIRNAME}/empty_section.txt"
    assert_output ''

    runWithFullOutput -0 dishOutSections "${BATS_TEST_DIRNAME}/empty_section.txt"
    assert_output ''

    runWithFullOutput -4 dishOutSections "${BATS_TEST_DIRNAME}/empty_section.txt"
    assert_output ''
}
