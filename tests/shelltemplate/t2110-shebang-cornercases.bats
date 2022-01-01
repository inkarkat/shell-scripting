#!/usr/bin/env bats

load fixture

@test "different shebang is kept" {
    run shelltemplate "${BATS_TEST_DIRNAME}/different-shebang"
    [ $status -eq 0 ]
    [ "$output" = "#!/bin/bash
$expected" ]
}

@test "second, different shebang is kept" {
    run "${BATS_TEST_DIRNAME}/two-shebangs"
    [ $status -eq 0 ]
    [ "$output" = "#!/bin/bash
$expected" ]
}

@test "empty second line after shebang is deleted" {
    run "${BATS_TEST_DIRNAME}/shebang-empty-line"
    [ $status -eq 0 ]
    [ "$output" = "$expected" ]
}
