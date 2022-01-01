#!/usr/bin/env bats

load fixture

@test "template file to standard out" {
    run shelltemplate "${BATS_TEST_DIRNAME}/input.txt"
    [ $status -eq 0 ]
    [ "$output" = "$expected" ]
    [ ! -e "$TARGET_FILE" ]
}

@test "-- template file to standard out" {
    run shelltemplate -- "${BATS_TEST_DIRNAME}/input.txt"
    [ $status -eq 0 ]
    [ "$output" = "$expected" ]
    [ ! -e "$TARGET_FILE" ]
}

@test "template file followed by target file" {
    run shelltemplate "${BATS_TEST_DIRNAME}/input.txt" "$TARGET_FILE"
    [ $status -eq 0 ]
    [ "$output" = "" ]
    [ "$(cat "$TARGET_FILE")" = "$expected" ]
}

@test "-- template file followed by target file" {
    run shelltemplate -- "${BATS_TEST_DIRNAME}/input.txt" "$TARGET_FILE"
    [ $status -eq 0 ]
    [ "$output" = "" ]
    [ "$(cat "$TARGET_FILE")" = "$expected" ]
}

@test "template file followed by --target file" {
    run shelltemplate "${BATS_TEST_DIRNAME}/input.txt" --target "$TARGET_FILE"
    [ $status -eq 0 ]
    [ "$output" = "" ]
    [ "$(cat "$TARGET_FILE")" = "$expected" ]
}

@test "--target file followed by template file" {
    run shelltemplate --target "$TARGET_FILE" "${BATS_TEST_DIRNAME}/input.txt"
    [ $status -eq 0 ]
    [ "$output" = "" ]
    [ "$(cat "$TARGET_FILE")" = "$expected" ]
}

@test "--target file followed by -- and template file" {
    run shelltemplate --target "$TARGET_FILE" -- "${BATS_TEST_DIRNAME}/input.txt"
    [ $status -eq 0 ]
    [ "$output" = "" ]
    [ "$(cat "$TARGET_FILE")" = "$expected" ]
}
