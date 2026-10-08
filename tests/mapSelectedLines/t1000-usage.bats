#!/usr/bin/env bats

load fixture

@test "no arguments prints message and usage instructions" {
    run -2 mapSelectedLines
    assert_line -n 0 'ERROR: No COMMAND(s) specified; need to pass -c|--command "COMMANDLINE", or --exec SIMPLECOMMAND [...] ; or SIMPLECOMMAND.'
    assert_line -n -2 -e '^Usage:'
}

@test "invalid option prints message and usage instructions" {
    run -2 mapSelectedLines --invalid-option
    assert_line -n 0 'ERROR: Unknown option "--invalid-option"!'
    assert_line -n -2 -e '^Usage:'
}

@test "-h prints long usage help" {
    run -0 mapSelectedLines -h
    refute_line -n 0 -e '^Usage:'
}
