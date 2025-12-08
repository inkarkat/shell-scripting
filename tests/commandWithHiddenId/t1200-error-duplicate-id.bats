#!/usr/bin/env bats

load fixture

@test "returns 125 if duplicate ID is passed and shows the ID" {
    run -125 commandWithHiddenId --piped --command 'grep oo' -- '1 foo' '2 bar' '4 boo' '2 duplicate' '9 quux'
    assert_output 'ERROR: Duplicate IDs: 2'
}

@test "returns 125 if multiple duplicate IDs are passed and shows the IDs" {
    run -125 commandWithHiddenId --piped --command 'grep oo' -- '1 foo' '2 bar' '1 boo' '2 duplicate' '9 quux'
    assert_output 'ERROR: Duplicate IDs: 1, 2'
}
