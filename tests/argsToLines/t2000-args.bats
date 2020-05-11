#!/usr/bin/env bats

@test "no supplied arguments give no output" {
    run argsToLines
    [ $status -eq 0 ]
    [ "$output" = "" ]
}

@test "a single argument is printed" {
    run argsToLines 'foo bar'
    [ $status -eq 0 ]
    [ "$output" = "foo bar" ]
}

@test "multiple arguments are printed on separate lines" {
    run argsToLines 'foo bar' 'quux' 'final'
    [ $status -eq 0 ]
    [ "$output" = "foo bar
quux
final" ]
}
