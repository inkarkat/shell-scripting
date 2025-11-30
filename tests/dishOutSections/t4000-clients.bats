#!/usr/bin/env bats

load fixture

@test "separate iterations with default and named client" {
    run dishOutSections "${BATS_TEST_DIRNAME}/numbers.txt"
    assert_output 'one'

    run dishOutSections --for another "${BATS_TEST_DIRNAME}/numbers.txt"
    assert_output 'one'

    run dishOutSections "${BATS_TEST_DIRNAME}/numbers.txt"
    assert_output 'two'

    run dishOutSections "${BATS_TEST_DIRNAME}/numbers.txt"
    assert_output 'three'

    run dishOutSections --for another "${BATS_TEST_DIRNAME}/numbers.txt"
    assert_output 'two'

    run dishOutSections --for another "${BATS_TEST_DIRNAME}/numbers.txt"
    assert_output 'three'

    run dishOutSections --for another "${BATS_TEST_DIRNAME}/numbers.txt"
    assert_output 'four'

    run dishOutSections --for another "${BATS_TEST_DIRNAME}/numbers.txt"
    assert_output 'five'

    run dishOutSections "${BATS_TEST_DIRNAME}/numbers.txt"
    assert_output 'four'

    run dishOutSections "${BATS_TEST_DIRNAME}/numbers.txt"
    assert_output 'five'

    run dishOutSections --for another "${BATS_TEST_DIRNAME}/numbers.txt"
    assert_output 'six'
}

@test "separate iterations with three clients" {
    run dishOutSections --for C "${BATS_TEST_DIRNAME}/numbers.txt"
    assert_output 'one'

    run dishOutSections --for C "${BATS_TEST_DIRNAME}/numbers.txt"
    assert_output 'two'

    run dishOutSections --for C "${BATS_TEST_DIRNAME}/numbers.txt"
    assert_output 'three'

    run dishOutSections --for A "${BATS_TEST_DIRNAME}/numbers.txt"
    assert_output 'one'

    run dishOutSections --for B "${BATS_TEST_DIRNAME}/numbers.txt"
    assert_output 'one'

    run dishOutSections --for A "${BATS_TEST_DIRNAME}/numbers.txt"
    assert_output 'two'

    run dishOutSections --for B "${BATS_TEST_DIRNAME}/numbers.txt"
    assert_output 'two'

    run dishOutSections --for B "${BATS_TEST_DIRNAME}/numbers.txt"
    assert_output 'three'

    run dishOutSections --for B "${BATS_TEST_DIRNAME}/numbers.txt"
    assert_output 'four'

    run dishOutSections --for B "${BATS_TEST_DIRNAME}/numbers.txt"
    assert_output 'five'

    run dishOutSections --for C "${BATS_TEST_DIRNAME}/numbers.txt"
    assert_output 'four'
}

@test "three clients seeking" {
    run dishOutSections --for C "${BATS_TEST_DIRNAME}/numbers.txt"
    assert_output 'one'

    run dishOutSections --for A "${BATS_TEST_DIRNAME}/numbers.txt"
    assert_output 'one'

    run dishOutSections --for B --seek 9 "${BATS_TEST_DIRNAME}/numbers.txt"
    assert_output 'nine'

    run dishOutSections --for A --seek 3 "${BATS_TEST_DIRNAME}/numbers.txt"
    assert_output 'three'

    run dishOutSections --for B "${BATS_TEST_DIRNAME}/numbers.txt"
    assert_output 'ten'

    run dishOutSections --for A --seek 2 "${BATS_TEST_DIRNAME}/numbers.txt"
    assert_output 'two'

    run dishOutSections --for B "${BATS_TEST_DIRNAME}/numbers.txt"
    assert_output 'eleven'

    run dishOutSections --for C "${BATS_TEST_DIRNAME}/numbers.txt"
    assert_output 'two'

    run dishOutSections --for A "${BATS_TEST_DIRNAME}/numbers.txt"
    assert_output 'three'
}

@test "three clients seeking and wrapping" {
    run dishOutSections --for C "${BATS_TEST_DIRNAME}/numbers.txt"
    assert_output 'one'

    run dishOutSections --for B --seek 9 "${BATS_TEST_DIRNAME}/numbers.txt"
    assert_output 'nine'

    run dishOutSections --for A --seek 11 "${BATS_TEST_DIRNAME}/numbers.txt"
    assert_output 'eleven'

    run dishOutSections --for B "${BATS_TEST_DIRNAME}/numbers.txt"
    assert_output 'ten'

    run dishOutSections --for A "${BATS_TEST_DIRNAME}/numbers.txt"
    assert_output 'twelve'

    run dishOutSections --for A --wrap "${BATS_TEST_DIRNAME}/numbers.txt"
    assert_output 'one'

    run dishOutSections --for B --seek 12 "${BATS_TEST_DIRNAME}/numbers.txt"
    assert_output 'twelve'

    run dishOutSections --for A "${BATS_TEST_DIRNAME}/numbers.txt"
    assert_output 'two'

    run dishOutSections -4 --for B "${BATS_TEST_DIRNAME}/numbers.txt"
}

@test "three clients seeking and resetting" {
    run dishOutSections "${BATS_TEST_DIRNAME}/numbers.txt"
    assert_output 'one'

    run dishOutSections --for B --seek 9 "${BATS_TEST_DIRNAME}/numbers.txt"
    assert_output 'nine'

    run dishOutSections --for A --seek 11 "${BATS_TEST_DIRNAME}/numbers.txt"
    assert_output 'eleven'

    run dishOutSections --for B --reset "${BATS_TEST_DIRNAME}/numbers.txt"
    assert_output 'ten'

    run dishOutSections --for A --reset "${BATS_TEST_DIRNAME}/numbers.txt"
    assert_output 'twelve'

    run dishOutSections --for A "${BATS_TEST_DIRNAME}/numbers.txt"
    assert_output 'one'

    run dishOutSections --for B "${BATS_TEST_DIRNAME}/numbers.txt"
    assert_output 'one'

    run dishOutSections --reset "${BATS_TEST_DIRNAME}/numbers.txt"
    assert_output 'two'

    run dishOutSections "${BATS_TEST_DIRNAME}/numbers.txt"
    assert_output 'one'
}
