#!/usr/bin/env bats

load fixture

@test "a command can select the same entry multiple times" {
    run commandWithHiddenId --piped --command 'echo -e bar\\nquux\\nbar\\nfoo\\nbar' -- "${INPUT[@]}"
    [ $status -eq 0 ]
    [ "$output" = "2
9
2
1
2" ]
}
