#!/usr/bin/env bats

load fixture

@test "directly seek to 1 again after first line" {
    run -0 dishOutSections --lines --seek-after 1 "${BATS_TEST_DIRNAME}/numbers-lines.txt"
    assert_output 'one'

    run -0 dishOutSections --lines "${BATS_TEST_DIRNAME}/numbers-lines.txt"
    assert_output 'one'
}

@test "seek to first line after three lines" {
    run -0 dishOutSections --lines "${BATS_TEST_DIRNAME}/numbers-lines.txt"
    run -0 dishOutSections --lines "${BATS_TEST_DIRNAME}/numbers-lines.txt"
    run -0 dishOutSections --lines --seek-after 1 "${BATS_TEST_DIRNAME}/numbers-lines.txt"
    run -0 dishOutSections --lines "${BATS_TEST_DIRNAME}/numbers-lines.txt"
    assert_output 'one'
}

@test "seek to second line and seek after it to line 5" {
    run -0 dishOutSections --lines --seek 2 --seek-after 5 "${BATS_TEST_DIRNAME}/numbers-lines.txt"
    assert_output 'two'

    run -0 dishOutSections --lines "${BATS_TEST_DIRNAME}/numbers-lines.txt"
    assert_output 'five'
}

@test "seek beyond last line with wrap and seek after" {
    run -0 dishOutSections --lines --seek $((LINE_NUM + 5)) --wrap --seek-after 2 "${BATS_TEST_DIRNAME}/numbers-lines.txt"
    assert_output 'five'

    run -0 dishOutSections --lines "${BATS_TEST_DIRNAME}/numbers-lines.txt"
    assert_output 'two'
}
