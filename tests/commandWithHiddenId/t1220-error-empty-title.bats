#!/usr/bin/env bats

load fixture

@test "returns 125 and error message if empty TITLE is passed" {
    run -125 commandWithHiddenId --piped --command 'grep oo' -- '1 foo' '2 bar' '4 ' '9 quux'
    assert_output 'ERROR: Empty TITLE(s).'
}
