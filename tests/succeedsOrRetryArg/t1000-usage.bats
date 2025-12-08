#!/usr/bin/env bats

load fixture

@test "no arguments prints message and usage instructions" {
    run -2 succeedsOrRetryArg
    assert_line -n 0 'ERROR: No ARG passed.'
    assert_line -n 1 -e '^Usage:'
}

@test "no commands prints message and usage instructions" {
    run -2 succeedsOrRetryArg arg
    assert_line -n 0 'ERROR: No COMMAND(s) specified; need to pass -c|--command "COMMANDLINE", or --exec SIMPLECOMMAND [...] ; or SIMPLECOMMAND.'
    assert_line -n 1 -e '^Usage:'
}

@test "invalid option prints message and usage instructions" {
    run -2 succeedsOrRetryArg --invalid-option
    assert_line -n 0 'ERROR: Unknown option "--invalid-option"!'
    assert_line -n 1 -e '^Usage:'
}

@test "-h prints long usage help" {
  run -0 succeedsOrRetryArg -h
    refute_line -n 0 -e '^Usage:'
}
