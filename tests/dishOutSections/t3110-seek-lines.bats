#!/usr/bin/env bats

load fixture

@test "seek to random existing line counts and print the successors" {
    run -0 dishOutSections --lines --seek 2 "${BATS_TEST_DIRNAME}/numbers-lines.txt"
    assert_output 'two'

    run -0 dishOutSections --lines "${BATS_TEST_DIRNAME}/numbers-lines.txt"
    assert_output 'three'

    run -0 dishOutSections --lines --seek 4 "${BATS_TEST_DIRNAME}/numbers-lines.txt"
    assert_output 'four'

    run -0 dishOutSections --lines --seek 1 "${BATS_TEST_DIRNAME}/numbers-lines.txt"
    assert_output 'one'

    run -0 dishOutSections --lines "${BATS_TEST_DIRNAME}/numbers-lines.txt"
    assert_output 'two'
}

@test "seek to last line stops further printing" {
    run -0 dishOutSections --lines --seek 12 "${BATS_TEST_DIRNAME}/numbers-lines.txt"
    assert_output 'twelve'

    run -4 dishOutSections --lines "${BATS_TEST_DIRNAME}/numbers-lines.txt"
    assert_output ''
}
