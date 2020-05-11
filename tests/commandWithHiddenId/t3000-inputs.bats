#!/usr/bin/env bats

load fixture

@test "input from stdin" {
    run commandWithInput --stdin --piped --command 'grep oo'
    [ $status -eq 0 ]
    [ "$output" = "1
4" ]
}

@test "input from the command-line" {
    run commandWithHiddenId --piped --command 'grep oo' -- "${INPUT[@]}"
    [ $status -eq 0 ]
    [ "$output" = "1
4" ]
}

@test "input from a generator" {
    run commandWithHiddenId --generator "echo '$INPUTSTRING'" --piped --command 'grep oo'
    [ $status -eq 0 ]
    [ "$output" = "1
4" ]
}

@test "input from a generator that embellishes the arguments from the command-line" {
    run commandWithHiddenId --generator "argsToLines -c 'nl -w1'" --piped --command 'grep oo' foo bar boo quux
    [ $status -eq 0 ]
    [ "$output" = "1
3" ]
}
