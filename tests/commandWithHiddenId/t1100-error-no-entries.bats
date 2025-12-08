#!/usr/bin/env bats

load fixture

@test "returns 124 if no arguments are available" {
    run -124 commandWithHiddenId --command 'grep oo'
    assert_output ''
}

@test "returns 124 if nothing is piped into it" {
    run -124 commandWithHiddenId --piped --command 'grep oo'
    assert_output ''
}

@test "returns 124 if everything is filtered out" {
    run -124 commandWithHiddenId --filter "argsToLines -c 'sed -e d'" --piped --command 'grep oo' -- "${INPUT[@]}"
    assert_output ''
}
