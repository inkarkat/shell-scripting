#!/usr/bin/env bats

load fixture

@test "No selections prints error and fails" {
    run -2 mapSelectedLines "${UPPERCASE_COMMAND[@]}"
    assert_line -n 0 'ERROR: No selections passed.'
    assert_line -n -2 -e '^Usage:'
}
