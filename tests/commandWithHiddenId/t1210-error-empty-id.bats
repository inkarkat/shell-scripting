#!/usr/bin/env bats

load fixture

@test "returns 125 and error message if empty ID is passed" {
    run -125 commandWithHiddenId --piped --command 'grep oo' -- '1 foo' '2 bar' ' empty duplicate' '9 quux'
    assert_output 'ERROR: Empty ID(s).'
}
