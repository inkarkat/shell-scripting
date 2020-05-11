#!/usr/bin/env bats

load fixture

@test "command that selectively chooses some piped arguments" {
    run commandWithInput --stdin --piped --command 'grep oo'
    [ $status -eq 0 ]
    [ "$output" = "1
4" ]
}
