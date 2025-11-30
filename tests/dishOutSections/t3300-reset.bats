#!/usr/bin/env bats

load fixture

@test "directly reset after first second" {
    run dishOutSections --reset "${BATS_TEST_DIRNAME}/input.txt"
    assert_output $'first section\nwith some text'

    run dishOutSections "${BATS_TEST_DIRNAME}/input.txt"
    assert_output $'first section\nwith some text'
}


@test "reset after three sections" {
    run dishOutSections "${BATS_TEST_DIRNAME}/input.txt"
    run dishOutSections "${BATS_TEST_DIRNAME}/input.txt"
    run dishOutSections --reset "${BATS_TEST_DIRNAME}/input.txt"
    run dishOutSections "${BATS_TEST_DIRNAME}/input.txt"
    assert_output $'first section\nwith some text'
}

@test "seek to second section and reset" {
    run dishOutSections --seek 2 --reset "${BATS_TEST_DIRNAME}/input.txt"
    assert_output 'second section, single line'

    run dishOutSections "${BATS_TEST_DIRNAME}/input.txt"
    assert_output $'first section\nwith some text'
}

@test "seek beyond last section with wrap and reset" {
    run dishOutSections --seek $((6 + 5)) --wrap --reset "${BATS_TEST_DIRNAME}/input.txt"
    assert_output 'fifth section after empty fourth section'

    run dishOutSections "${BATS_TEST_DIRNAME}/input.txt"
    assert_output $'first section\nwith some text'
}
