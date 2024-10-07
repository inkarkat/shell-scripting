#!/usr/bin/env bats

@test "no arguments prints message and usage instructions" {
    run withPreprocessedInput
    [ $status -eq 2 ]
    [ "${lines[0]}" = 'ERROR: No PREPROCESS-COMMAND(s) specified; need to pass --preprocess-command "COMMANDLINE", or --preprocess-exec SIMPLECOMMAND [...] ;.' ]
    [ "${lines[1]%% *}" = 'Usage:' ]
}

@test "missing SIMPLECOMMAND argument prints message and usage instructions" {
    run withPreprocessedInput --preprocess-command :
    [ $status -eq 2 ]
    [ "${lines[0]}" = 'ERROR: No COMMAND(s) specified; need to pass -c|--command "COMMANDLINE", or --exec SIMPLECOMMAND [...] ; or SIMPLECOMMAND.' ]
    [ "${lines[1]%% *}" = 'Usage:' ]
}

@test "invalid option prints message and usage instructions" {
    run withPreprocessedInput --invalid-option
    [ $status -eq 2 ]
    [ "${lines[0]}" = 'ERROR: Unknown option "--invalid-option"!' ]
    [ "${lines[1]%% *}" = 'Usage:' ]
}

@test "-h prints long usage help" {
    run withPreprocessedInput -h
    [ $status -eq 0 ]
    [ "${lines[7]%% *}" != 'Usage:' ]
}
