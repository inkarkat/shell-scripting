#!/usr/bin/env bats

@test "returns 124 if no arguments are available" {
    run commandWithHiddenId --command 'grep oo'
    [ $status -eq 124 ]
    [ "$output" = "" ]
}

@test "returns 124 if nothing is piped into it" {
    run commandWithHiddenId --piped --command 'grep oo'
    [ $status -eq 124 ]
    [ "$output" = "" ]
}

@test "returns 124 if everything is filtered out" {
    run commandWithHiddenId --filter "argsToLines -c 'sed -e d'" --piped --command 'grep oo' -- "${INPUT[@]}"
    [ $status -eq 124 ]
    [ "$output" = "" ]
}
