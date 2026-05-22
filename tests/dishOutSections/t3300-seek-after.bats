#!/usr/bin/env bats

load fixture

@test "directly seek to 1 again after first section" {
    run -0 dishOutSections --seek-after 1 "${BATS_TEST_DIRNAME}/input.txt"
    assert_output $'first section\nwith some text'

    run -0 dishOutSections "${BATS_TEST_DIRNAME}/input.txt"
    assert_output $'first section\nwith some text'
}

@test "seek to first section after three sections" {
    run -0 dishOutSections "${BATS_TEST_DIRNAME}/input.txt"
    run -0 dishOutSections "${BATS_TEST_DIRNAME}/input.txt"
    run -0 dishOutSections --seek-after 1 "${BATS_TEST_DIRNAME}/input.txt"
    run -0 dishOutSections "${BATS_TEST_DIRNAME}/input.txt"
    assert_output $'first section\nwith some text'
}

@test "seek to second section and seek after it to section 5" {
    run -0 dishOutSections --seek 2 --seek-after 5 "${BATS_TEST_DIRNAME}/input.txt"
    assert_output 'second section, single line'

    run -0 dishOutSections "${BATS_TEST_DIRNAME}/input.txt"
    assert_output 'fifth section after empty fourth section'
}

@test "seek beyond last section with wrap and seek after" {
    run -0 dishOutSections --seek $((SECTION_NUM + 5)) --wrap --seek-after 2 "${BATS_TEST_DIRNAME}/input.txt"
    assert_output 'fifth section after empty fourth section'

    run -0 dishOutSections "${BATS_TEST_DIRNAME}/input.txt"
    assert_output 'second section, single line'
}

@test "seek beyond last section still executes seek after" {
    run -4 dishOutSections --seek $((SECTION_NUM + 1)) --seek-after 2 "${BATS_TEST_DIRNAME}/input.txt"
    assert_output ''

    run -0 dishOutSections "${BATS_TEST_DIRNAME}/input.txt"
    assert_output 'second section, single line'
}
