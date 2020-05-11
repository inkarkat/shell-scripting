#!/usr/bin/env bats

@test "returns 125 and error message if empty TITLE is passed" {
    run commandWithHiddenId --piped --command 'grep oo' -- '1 foo' '2 bar' '4 ' '9 quux'
    [ $status -eq 125 ]
    [ "$output" = "ERROR: Empty TITLE(s)." ]
}
