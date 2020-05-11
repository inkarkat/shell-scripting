#!/usr/bin/env bats

load fixture

@test "command that does not output anything yields no IDs" {
    run commandWithHiddenId --piped --command 'sed -e d' -- "${INPUT[@]}"
    [ $status -eq 0 ]
    [ "$output" = "" ]
}
