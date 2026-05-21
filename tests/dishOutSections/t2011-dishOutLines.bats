#!/usr/bin/env bats

load fixture

@test "dedicated dishOutLines command works" {
    run -0 dishOutLines --count 1 "${BATS_TEST_DIRNAME}/numbers-lines.txt"
    assert_output 'one'

    run -0 dishOutLines --count 2 "${BATS_TEST_DIRNAME}/numbers-lines.txt"
    assert_output 'two'

    run -0 dishOutLines --count 12 "${BATS_TEST_DIRNAME}/numbers-lines.txt"
    assert_output 'twelve'
}
