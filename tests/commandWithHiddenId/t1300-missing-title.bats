#!/usr/bin/env bats

load fixture

@test "a missing TITLE is defaulted to its ID" {
    run commandWithHiddenId --piped --command 'grep oo\\\|00' -- '100' "${INPUT[@]}" '1001'
    [ $status -eq 0 ]
    [ "$output" = "100
1
4
1001" ]
}
