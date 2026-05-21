#!/usr/bin/env bats

load fixture

@test "directly reset after first line" {
    run -0 dishOutSections --lines --reset "${BATS_TEST_DIRNAME}/numbers-lines.txt"
    assert_output 'one'

    run -0 dishOutSections --lines "${BATS_TEST_DIRNAME}/numbers-lines.txt"
    assert_output 'one'
}


@test "reset after three lines" {
    run -0 dishOutSections --lines "${BATS_TEST_DIRNAME}/numbers-lines.txt"
    run -0 dishOutSections --lines "${BATS_TEST_DIRNAME}/numbers-lines.txt"
    run -0 dishOutSections --lines --reset "${BATS_TEST_DIRNAME}/numbers-lines.txt"
    run -0 dishOutSections --lines "${BATS_TEST_DIRNAME}/numbers-lines.txt"
    assert_output 'one'
}

@test "seek to second line and reset" {
    run -0 dishOutSections --lines --seek 2 --reset "${BATS_TEST_DIRNAME}/numbers-lines.txt"
    assert_output 'two'

    run -0 dishOutSections --lines "${BATS_TEST_DIRNAME}/numbers-lines.txt"
    assert_output 'one'
}

@test "seek beyond last line with wrap and reset" {
    run -0 dishOutSections --lines --seek $((LINE_NUM + 5)) --wrap --reset "${BATS_TEST_DIRNAME}/numbers-lines.txt"
    assert_output 'five'

    run -0 dishOutSections --lines "${BATS_TEST_DIRNAME}/numbers-lines.txt"
    assert_output 'one'
}
