#!/usr/bin/env bats

@test "returns 125 and error message if empty ID is passed" {
    run commandWithHiddenId --piped --command 'grep oo' -- '1 foo' '2 bar' ' empty duplicate' '9 quux'
    [ $status -eq 125 ]
    [ "$output" = "ERROR: Empty ID(s)." ]
}
