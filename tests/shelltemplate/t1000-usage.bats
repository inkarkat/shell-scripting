#!/usr/bin/env bats

@test "-h prints long usage help" {
  run shelltemplate -h
    [ $status -eq 0 ]
    [ "${lines[0]%% *}" != 'Usage:' ]
    [ "${lines[-1]%% *}" = 'Usage:' ]
}

@test "3 arguments with --file gives error and usage" {
    run shelltemplate --file input.txt output.txt additional.txt
    [ $status -eq 2 ]
    [ "${lines[-1]%% *}" = 'Usage:' ]
}

@test "3 arguments without --file gives error and usage" {
    run shelltemplate output.txt input.txt additional.txt
    [ $status -eq 2 ]
    [ "${lines[-1]%% *}" = 'Usage:' ]
}

@test "4 arguments with -- gives error and usage" {
    run shelltemplate -- output.txt input.txt additional.txt
    [ $status -eq 2 ]
    [ "${lines[-1]%% *}" = 'Usage:' ]
}

@test "duplicate --file gives error and usage" {
    run shelltemplate --file input.txt --file additional.txt
    [ $status -eq 2 ]
    [ "${lines[-1]%% *}" = 'Usage:' ]
}
