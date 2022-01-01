#!/usr/bin/env bats

load fixture

@test "shebang to standard out" {
    run "${BATS_TEST_DIRNAME}/shebang-input"
    [ $status -eq 0 ]
    [ "$output" = "$expected" ]
    [ ! -e "$TARGET_FILE" ]
}

@test "shebang to passed target file" {
    run "${BATS_TEST_DIRNAME}/shebang-input" "$TARGET_FILE"
    [ $status -eq 0 ]
    [ "$output" = "" ]
    [ "$(cat "$TARGET_FILE")" = "$expected" ]
}

@test "shebang to passed --target file" {
    run "${BATS_TEST_DIRNAME}/shebang-input" --target "$TARGET_FILE"
    [ $status -eq 0 ]
    [ "$output" = "" ]
    [ "$(cat "$TARGET_FILE")" = "$expected" ]
}

@test "shebang with two passed files gives error and usage" {
    run "${BATS_TEST_DIRNAME}/shebang-input" "$TARGET_FILE" additional.txt
    [ $status -eq 2 ]
    [ "${lines[-1]%% *}" = 'Usage:' ]
    [ ! -e "$TARGET_FILE" ]
}

@test "shebang to embedded target file" {
    run "${BATS_TEST_DIRNAME}/shebang-output"
    [ $status -eq 0 ]
    [ "$output" = "" ]
    [ "$(cat /tmp/output.txt)" = "$expected" ]
}

@test "shebang to embedded target file with passed file gives error and usage" {
    run "${BATS_TEST_DIRNAME}/shebang-output" additional.txt
    [ $status -eq 2 ]
    [ "${lines[-1]%% *}" = 'Usage:' ]
    [ ! -e "$TARGET_FILE" ]
}
