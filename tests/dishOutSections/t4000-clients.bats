#!/usr/bin/env bats

load fixture

@test "separate iterations with default and named client" {
    run -0 dishOutSections "${BATS_TEST_DIRNAME}/numbers.txt"
    assert_output 'one'

    run -0 dishOutSections --for another "${BATS_TEST_DIRNAME}/numbers.txt"
    assert_output 'one'

    run -0 dishOutSections "${BATS_TEST_DIRNAME}/numbers.txt"
    assert_output 'two'

    run -0 dishOutSections "${BATS_TEST_DIRNAME}/numbers.txt"
    assert_output 'three'

    run -0 dishOutSections --for another "${BATS_TEST_DIRNAME}/numbers.txt"
    assert_output 'two'

    run -0 dishOutSections --for another "${BATS_TEST_DIRNAME}/numbers.txt"
    assert_output 'three'

    run -0 dishOutSections --for another "${BATS_TEST_DIRNAME}/numbers.txt"
    assert_output 'four'

    run -0 dishOutSections --for another "${BATS_TEST_DIRNAME}/numbers.txt"
    assert_output 'five'

    run -0 dishOutSections "${BATS_TEST_DIRNAME}/numbers.txt"
    assert_output 'four'

    run -0 dishOutSections "${BATS_TEST_DIRNAME}/numbers.txt"
    assert_output 'five'

    run -0 dishOutSections --for another "${BATS_TEST_DIRNAME}/numbers.txt"
    assert_output 'six'
}

@test "separate iterations with three clients" {
    run -0 dishOutSections --for C "${BATS_TEST_DIRNAME}/numbers.txt"
    assert_output 'one'

    run -0 dishOutSections --for C "${BATS_TEST_DIRNAME}/numbers.txt"
    assert_output 'two'

    run -0 dishOutSections --for C "${BATS_TEST_DIRNAME}/numbers.txt"
    assert_output 'three'

    run -0 dishOutSections --for A "${BATS_TEST_DIRNAME}/numbers.txt"
    assert_output 'one'

    run -0 dishOutSections --for B "${BATS_TEST_DIRNAME}/numbers.txt"
    assert_output 'one'

    run -0 dishOutSections --for A "${BATS_TEST_DIRNAME}/numbers.txt"
    assert_output 'two'

    run -0 dishOutSections --for B "${BATS_TEST_DIRNAME}/numbers.txt"
    assert_output 'two'

    run -0 dishOutSections --for B "${BATS_TEST_DIRNAME}/numbers.txt"
    assert_output 'three'

    run -0 dishOutSections --for B "${BATS_TEST_DIRNAME}/numbers.txt"
    assert_output 'four'

    run -0 dishOutSections --for B "${BATS_TEST_DIRNAME}/numbers.txt"
    assert_output 'five'

    run -0 dishOutSections --for C "${BATS_TEST_DIRNAME}/numbers.txt"
    assert_output 'four'
}

@test "three clients seeking" {
    run -0 dishOutSections --for C "${BATS_TEST_DIRNAME}/numbers.txt"
    assert_output 'one'

    run -0 dishOutSections --for A "${BATS_TEST_DIRNAME}/numbers.txt"
    assert_output 'one'

    run -0 dishOutSections --for B --seek 9 "${BATS_TEST_DIRNAME}/numbers.txt"
    assert_output 'nine'

    run -0 dishOutSections --for A --seek 3 "${BATS_TEST_DIRNAME}/numbers.txt"
    assert_output 'three'

    run -0 dishOutSections --for B "${BATS_TEST_DIRNAME}/numbers.txt"
    assert_output 'ten'

    run -0 dishOutSections --for A --seek 2 "${BATS_TEST_DIRNAME}/numbers.txt"
    assert_output 'two'

    run -0 dishOutSections --for B "${BATS_TEST_DIRNAME}/numbers.txt"
    assert_output 'eleven'

    run -0 dishOutSections --for C "${BATS_TEST_DIRNAME}/numbers.txt"
    assert_output 'two'

    run -0 dishOutSections --for A "${BATS_TEST_DIRNAME}/numbers.txt"
    assert_output 'three'
}

@test "three clients seeking and wrapping" {
    run -0 dishOutSections --for C "${BATS_TEST_DIRNAME}/numbers.txt"
    assert_output 'one'

    run -0 dishOutSections --for B --seek 9 "${BATS_TEST_DIRNAME}/numbers.txt"
    assert_output 'nine'

    run -0 dishOutSections --for A --seek 11 "${BATS_TEST_DIRNAME}/numbers.txt"
    assert_output 'eleven'

    run -0 dishOutSections --for B "${BATS_TEST_DIRNAME}/numbers.txt"
    assert_output 'ten'

    run -0 dishOutSections --for A "${BATS_TEST_DIRNAME}/numbers.txt"
    assert_output 'twelve'

    run -0 dishOutSections --for A --wrap "${BATS_TEST_DIRNAME}/numbers.txt"
    assert_output 'one'

    run -0 dishOutSections --for B --seek 12 "${BATS_TEST_DIRNAME}/numbers.txt"
    assert_output 'twelve'

    run -0 dishOutSections --for A "${BATS_TEST_DIRNAME}/numbers.txt"
    assert_output 'two'

    run -4 dishOutSections --for B "${BATS_TEST_DIRNAME}/numbers.txt"
}

@test "three clients seeking and resetting" {
    run -0 dishOutSections "${BATS_TEST_DIRNAME}/numbers.txt"
    assert_output 'one'

    run -0 dishOutSections --for B --seek 9 "${BATS_TEST_DIRNAME}/numbers.txt"
    assert_output 'nine'

    run -0 dishOutSections --for A --seek 11 "${BATS_TEST_DIRNAME}/numbers.txt"
    assert_output 'eleven'

    run -0 dishOutSections --for B --reset "${BATS_TEST_DIRNAME}/numbers.txt"
    assert_output 'ten'

    run -0 dishOutSections --for A --reset "${BATS_TEST_DIRNAME}/numbers.txt"
    assert_output 'twelve'

    run -0 dishOutSections --for A "${BATS_TEST_DIRNAME}/numbers.txt"
    assert_output 'one'

    run -0 dishOutSections --for B "${BATS_TEST_DIRNAME}/numbers.txt"
    assert_output 'one'

    run -0 dishOutSections --reset "${BATS_TEST_DIRNAME}/numbers.txt"
    assert_output 'two'

    run -0 dishOutSections "${BATS_TEST_DIRNAME}/numbers.txt"
    assert_output 'one'
}
