#!/usr/bin/env bats

load fixture

@test "empty file prints one empty section" {
    run -0 dishOutSections "${BATS_TEST_DIRNAME}/empty.txt"
    assert_output ''

    run -4 dishOutSections "${BATS_TEST_DIRNAME}/empty.txt"
    assert_output ''
}

@test "file with just one separator prints two empty sections" {
    run -0 dishOutSections "${BATS_TEST_DIRNAME}/empty_section.txt"
    assert_output ''

    run -0 dishOutSections "${BATS_TEST_DIRNAME}/empty_section.txt"
    assert_output ''

    run -4 dishOutSections "${BATS_TEST_DIRNAME}/empty_section.txt"
    assert_output ''
}
