#!/usr/bin/env bats

load fixture

@test "input file to standard out" {
    run shelltemplate --file "${BATS_TEST_DIRNAME}/input.txt"
    [ $status -eq 0 ]
    [ "$output" = "$expected" ]
    [ ! -e "$TARGET_FILE" ]
}

@test "--file input file followed by target file" {
    run shelltemplate --file "${BATS_TEST_DIRNAME}/input.txt" "$TARGET_FILE"
    [ $status -eq 0 ]
    [ "$output" = "" ]
    [ "$(cat "$TARGET_FILE")" = "$expected" ]
}

@test "target file followed by input file" {
    run shelltemplate "$TARGET_FILE" "${BATS_TEST_DIRNAME}/input.txt"
    [ $status -eq 0 ]
    [ "$output" = "" ]
    [ "$(cat "$TARGET_FILE")" = "$expected" ]
}

@test "-- target file followed by input file" {
    run shelltemplate -- "$TARGET_FILE" "${BATS_TEST_DIRNAME}/input.txt"
    [ $status -eq 0 ]
    [ "$output" = "" ]
    [ "$(cat "$TARGET_FILE")" = "$expected" ]
}
