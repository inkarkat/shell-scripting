#!/usr/bin/env bats

load fixture

@test "no arguments prints message and usage instructions" {
    run -2 dishOutSections
    assert_line -n 0 'ERROR: No FILE passed.'
    assert_line -n 1 -e '^Usage:'
}

@test "invalid option prints message and usage instructions" {
    run -2 dishOutSections --invalid-option
    assert_line -n 0 'ERROR: Unknown option "--invalid-option"!'
    assert_line -n 1 -e '^Usage:'
}

@test "-h prints long usage help" {
    run -0 dishOutSections -h
    refute_line -n 0 -e '^Usage:'
}

@test "error when no FILE passed" {
    run -2 dishOutSections --count 2 --wrap
    assert_line -n 0 'ERROR: No FILE passed.'
    assert_line -n 1 -e '^Usage:'
}

@test "error when multiple FILEs passed" {
    run -2 dishOutSections --count 2 --wrap "${BATS_TEST_DIRNAME}/input.txt" "${BATS_TEST_DIRNAME}/numbers.txt"
    assert_line -n 0 'ERROR: Need one FILE.'
    assert_line -n 1 -e '^Usage:'
}
