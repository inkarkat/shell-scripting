#!/usr/bin/env bats

load fixture

@test "command that does not output anything yields no IDs" {
    run -0 commandWithHiddenId --piped --command 'sed -e d' -- "${INPUT[@]}"
    assert_output ''
}
