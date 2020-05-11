#!/usr/bin/env bats

load fixture

@test "without generator and with filter, no passed entries cause error" {
    run commandWithHiddenId --filter 'sed -e /f/d -e s/u/o/g' --piped --command 'grep oo'
    [ $status -eq 124 ]
    [ "$output" = "" ]
}

@test "without generator and with filter, passed entries are filtered" {
    run commandWithHiddenId --filter "argsToLines -c 'sed -e /f/d -e s/u/o/g'" --piped --command 'grep oo' -- "${INPUT[@]}"
    [ $status -eq 0 ]
    [ "$output" = "4
9" ]
}

@test "without generator and with empty filter, passed entries are used directly" {
    run commandWithHiddenId --filter '' --piped --command 'grep oo' -- "${INPUT[@]}"
    [ $status -eq 0 ]
    [ "$output" = "1
4" ]
}

@test "with generator and with filter, no passed entries use generator" {
    run commandWithHiddenId --generator "echo '$INPUTSTRING'" --filter 'sed -e /f/d -e s/u/o/g' --piped --command 'grep oo'
    [ $status -eq 0 ]
    [ "$output" = "1
4" ]
}

@test "with generator and with filter, passed entries are filtered" {
    run commandWithHiddenId --generator "echo '$INPUTSTRING'" --filter "argsToLines -c 'sed -e /f/d -e s/u/o/g'" --piped --command 'grep oo' -- "${INPUT[@]/#/5}"
    [ $status -eq 0 ]
    [ "$output" = "54
59" ]
}

@test "with generator and with empty filter, passed entries are used directly" {
    run commandWithHiddenId --generator "echo '$INPUTSTRING'" --filter '' --piped --command 'grep oo' -- "${INPUT[@]/#/5}"
    [ $status -eq 0 ]
    [ "$output" = "51
54" ]
}
