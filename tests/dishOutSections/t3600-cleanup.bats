#!/usr/bin/env bats

load fixture

@test "cleanup before any section queries" {
    run -0 dishOutSections --cleanup "${BATS_TEST_DIRNAME}/input.txt"

    run -0 dishOutSections "${BATS_TEST_DIRNAME}/input.txt"
    assert_output $'first section\nwith some text'
}

@test "cleanup after first section" {
    run -0 dishOutSections "${BATS_TEST_DIRNAME}/input.txt"
    assert_output $'first section\nwith some text'

    run -0 dishOutSections --cleanup "${BATS_TEST_DIRNAME}/input.txt"

    run -0 dishOutSections "${BATS_TEST_DIRNAME}/input.txt"
    assert_output $'first section\nwith some text'
}
