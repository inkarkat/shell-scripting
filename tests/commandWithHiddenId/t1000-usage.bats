#!/usr/bin/env bats

@test "no arguments prints message and usage instructions" {
    run commandWithHiddenId
    [ $status -eq 2 ]
    [ "${lines[0]}" = "ERROR: No -c|--command passed." ]
    [ "${lines[2]%% *}" = 'Usage:' ]
}

@test "invalid option prints message and usage instructions" {
    run commandWithHiddenId --invalid-option
    [ $status -eq 2 ]
    [ "${lines[0]}" = 'ERROR: Unknown option "--invalid-option"!' ]
    [ "${lines[2]%% *}" = 'Usage:' ]
}

@test "-h prints long usage help" {
  run commandWithHiddenId -h
    [ $status -eq 0 ]
    [ "${lines[0]%% *}" != 'Usage:' ]
}
