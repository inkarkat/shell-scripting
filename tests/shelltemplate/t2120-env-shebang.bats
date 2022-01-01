#!/usr/bin/env bats

load fixture

@test "env shebang to standard out" {
    run "${BATS_TEST_DIRNAME}/env-shebang"
    [ $status -eq 0 ]
    [ "$output" = "$expected" ]
    [ ! -e "$TARGET_FILE" ]
}

@test "env shebang to passed target file" {
    run "${BATS_TEST_DIRNAME}/env-shebang" "$TARGET_FILE"
    [ $status -eq 0 ]
    [ "$output" = "" ]
    [ "$(cat "$TARGET_FILE")" = "$expected" ]
}

@test "env shebang to passed --target file" {
    run "${BATS_TEST_DIRNAME}/env-shebang" --target "$TARGET_FILE"
    [ $status -eq 0 ]
    [ "$output" = "" ]
    [ "$(cat "$TARGET_FILE")" = "$expected" ]
}

@test "env shebang with two passed files gives error and usage" {
    run "${BATS_TEST_DIRNAME}/env-shebang" "$TARGET_FILE" additional.txt
    [ $status -eq 2 ]
    [ "${lines[-1]%% *}" = 'Usage:' ]
    [ ! -e "$TARGET_FILE" ]
}
