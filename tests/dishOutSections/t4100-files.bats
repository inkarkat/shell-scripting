#!/usr/bin/env bats

load fixture

@test "concurrent iterations of different files" {
    run -0 dishOutSections "${BATS_TEST_DIRNAME}/numbers.txt"
    assert_output 'one'

    run -0 dishOutSections "${BATS_TEST_DIRNAME}/input.txt"
    assert_output $'first section\nwith some text'

    run -0 dishOutSections "${BATS_TEST_DIRNAME}/input.txt"
    assert_output 'second section, single line'

    run -0 dishOutSections "${BATS_TEST_DIRNAME}/numbers.txt"
    assert_output 'two'

    run -0 dishOutSections "${BATS_TEST_DIRNAME}/numbers.txt"
    assert_output 'three'

    run -0 dishOutSections "${BATS_TEST_DIRNAME}/input.txt"
    assert_output $'third section with empty lines\n\n\nthe end'

    run -0 dishOutSections "${BATS_TEST_DIRNAME}/numbers.txt"
    assert_output 'four'
}

@test "iteration tracking of different files can be overwritten" {
    export DISHOUTSECTIONS_FILENAME=numbers-and-input
    run -0 dishOutSections "${BATS_TEST_DIRNAME}/numbers.txt"
    assert_output 'one'

    run -0 dishOutSections "${BATS_TEST_DIRNAME}/input.txt"
    assert_output 'second section, single line'

    run -0 dishOutSections "${BATS_TEST_DIRNAME}/numbers.txt"
    assert_output 'three'

    run -0 dishOutSections "${BATS_TEST_DIRNAME}/numbers.txt"
    assert_output 'four'

    run -0 dishOutSections "${BATS_TEST_DIRNAME}/input.txt"
    assert_output 'fifth section after empty fourth section'

    run -0 dishOutSections "${BATS_TEST_DIRNAME}/numbers.txt"
    assert_output 'six'

    run -4 dishOutSections "${BATS_TEST_DIRNAME}/input.txt"
    assert_output ''
}
