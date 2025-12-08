#!/usr/bin/env bats

load fixture

@test "directly reset after first second" {
    run -0 dishOutSections --reset "${BATS_TEST_DIRNAME}/input.txt"
    assert_output $'first section\nwith some text'

    run -0 dishOutSections "${BATS_TEST_DIRNAME}/input.txt"
    assert_output $'first section\nwith some text'
}


@test "reset after three sections" {
    run -0 dishOutSections "${BATS_TEST_DIRNAME}/input.txt"
    run -0 dishOutSections "${BATS_TEST_DIRNAME}/input.txt"
    run -0 dishOutSections --reset "${BATS_TEST_DIRNAME}/input.txt"
    run -0 dishOutSections "${BATS_TEST_DIRNAME}/input.txt"
    assert_output $'first section\nwith some text'
}

@test "seek to second section and reset" {
    run -0 dishOutSections --seek 2 --reset "${BATS_TEST_DIRNAME}/input.txt"
    assert_output 'second section, single line'

    run -0 dishOutSections "${BATS_TEST_DIRNAME}/input.txt"
    assert_output $'first section\nwith some text'
}

@test "seek beyond last section with wrap and reset" {
    run -0 dishOutSections --seek $((6 + 5)) --wrap --reset "${BATS_TEST_DIRNAME}/input.txt"
    assert_output 'fifth section after empty fourth section'

    run -0 dishOutSections "${BATS_TEST_DIRNAME}/input.txt"
    assert_output $'first section\nwith some text'
}
