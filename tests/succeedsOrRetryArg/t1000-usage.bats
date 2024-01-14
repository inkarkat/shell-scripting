#!/usr/bin/env bats

@test "no arguments prints message and usage instructions" {
    run succeedsOrRetryArg
    [ $status -eq 2 ]
    [ "${lines[0]}" = 'ERROR: No ARG passed.' ]
    [ "${lines[1]%% *}" = 'Usage:' ]
}

@test "no commands prints message and usage instructions" {
    run succeedsOrRetryArg arg
    [ $status -eq 2 ]
    [ "${lines[0]}" = 'ERROR: No COMMAND(s) specified; need to pass -c|--command "COMMANDLINE", or --exec SIMPLECOMMAND [...] ; or SIMPLECOMMAND.' ]
    [ "${lines[1]%% *}" = 'Usage:' ]
}

@test "invalid option prints message and usage instructions" {
    run succeedsOrRetryArg --invalid-option
    [ $status -eq 2 ]
    [ "${lines[0]}" = 'ERROR: Unknown option "--invalid-option"!' ]
    [ "${lines[1]%% *}" = 'Usage:' ]
}

@test "-h prints long usage help" {
  run succeedsOrRetryArg -h
    [ $status -eq 0 ]
    [ "${lines[0]%% *}" != 'Usage:' ]
}
