#!/usr/bin/env bats

@test "returns 125 if duplicate ID is passed and shows the ID" {
    run commandWithHiddenId --piped --command 'grep oo' -- '1 foo' '2 bar' '4 boo' '2 duplicate' '9 quux'
    [ $status -eq 125 ]
    [ "$output" = "ERROR: Duplicate IDs: 2" ]
}

@test "returns 125 if multiple duplicate IDs are passed and shows the IDs" {
    run commandWithHiddenId --piped --command 'grep oo' -- '1 foo' '2 bar' '1 boo' '2 duplicate' '9 quux'
    [ $status -eq 125 ]
    [ "$output" = "ERROR: Duplicate IDs: 1, 2" ]
}
