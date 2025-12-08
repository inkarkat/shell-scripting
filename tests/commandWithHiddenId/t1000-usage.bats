#!/usr/bin/env bats

load fixture

@test "no arguments prints message and usage instructions" {
    run -2 commandWithHiddenId
    assert_line -n 0 "ERROR: No -c|--command passed."
    assert_line -n 2 -e '^Usage:'
}

@test "invalid option prints message and usage instructions" {
    run -2 commandWithHiddenId --invalid-option
    assert_line -n 0 'ERROR: Unknown option "--invalid-option"!'
    assert_line -n 2 -e '^Usage:'
}

@test "-h prints long usage help" {
  run -0 commandWithHiddenId -h
    refute_line -n 0 -e '^Usage:'
}
