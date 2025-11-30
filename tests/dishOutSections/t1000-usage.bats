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
