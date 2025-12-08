#!/usr/bin/env bats

load fixture

@test "no arguments prints message and usage instructions" {
    run -2 withPreprocessedInput
    assert_line -n 0 'ERROR: No PREPROCESS-COMMAND(s) specified; need to pass --preprocess-command "COMMANDLINE", or --preprocess-exec SIMPLECOMMAND [...] ;.'
    assert_line -n 1 -e '^Usage:'
}

@test "missing SIMPLECOMMAND argument prints message and usage instructions" {
    run -2 withPreprocessedInput --preprocess-command :
    assert_line -n 0 'ERROR: No COMMAND(s) specified; need to pass -c|--command "COMMANDLINE", or --exec SIMPLECOMMAND [...] ; or SIMPLECOMMAND.'
    assert_line -n 1 -e '^Usage:'
}

@test "invalid option prints message and usage instructions" {
    run -2 withPreprocessedInput --invalid-option
    assert_line -n 0 'ERROR: Unknown option "--invalid-option"!'
    assert_line -n 1 -e '^Usage:'
}

@test "-h prints long usage help" {
    run -0 withPreprocessedInput -h
    refute_line -n 7 -e '^Usage:'
}
