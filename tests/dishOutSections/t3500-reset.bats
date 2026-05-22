#!/usr/bin/env bats

load fixture

@test "reset before any section queries" {
    run -0 dishOutSections --reset "${BATS_TEST_DIRNAME}/input.txt"

    run -0 dishOutSections "${BATS_TEST_DIRNAME}/input.txt"
    assert_output $'first section\nwith some text'
}

@test "reset after first section" {
    run -0 dishOutSections "${BATS_TEST_DIRNAME}/input.txt"
    assert_output $'first section\nwith some text'

    run -0 dishOutSections --reset "${BATS_TEST_DIRNAME}/input.txt"

    run -0 dishOutSections "${BATS_TEST_DIRNAME}/input.txt"
    assert_output $'first section\nwith some text'
}

@test "reset to first section after two sections" {
    run -0 dishOutSections "${BATS_TEST_DIRNAME}/input.txt"
    run -0 dishOutSections "${BATS_TEST_DIRNAME}/input.txt"
    run -0 dishOutSections --reset "${BATS_TEST_DIRNAME}/input.txt"
    assert_output ''
    run -0 dishOutSections "${BATS_TEST_DIRNAME}/input.txt"
    assert_output $'first section\nwith some text'
}
