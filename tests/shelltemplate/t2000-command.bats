#!/usr/bin/env bats

load fixture

@test "template file to standard out" {
    run -0 shelltemplate "${BATS_TEST_DIRNAME}/input.txt"
    assert_output "$expected"
    assert_not_exists "$TARGET_FILE"
}

@test "-- template file to standard out" {
    run -0 shelltemplate -- "${BATS_TEST_DIRNAME}/input.txt"
    assert_output "$expected"
    assert_not_exists "$TARGET_FILE"
}

@test "template file followed by target file" {
    run -0 shelltemplate "${BATS_TEST_DIRNAME}/input.txt" "$TARGET_FILE"
    assert_output ''
    assert_equal "$(<"$TARGET_FILE")" "$expected"
}

@test "-- template file followed by target file" {
    run -0 shelltemplate -- "${BATS_TEST_DIRNAME}/input.txt" "$TARGET_FILE"
    assert_output ''
    assert_equal "$(<"$TARGET_FILE")" "$expected"
}

@test "template file followed by --target file" {
    run -0 shelltemplate "${BATS_TEST_DIRNAME}/input.txt" --target "$TARGET_FILE"
    assert_output ''
    assert_equal "$(<"$TARGET_FILE")" "$expected"
}

@test "--target file followed by template file" {
    run -0 shelltemplate --target "$TARGET_FILE" "${BATS_TEST_DIRNAME}/input.txt"
    assert_output ''
    assert_equal "$(<"$TARGET_FILE")" "$expected"
}

@test "--target file followed by -- and template file" {
    run -0 shelltemplate --target "$TARGET_FILE" -- "${BATS_TEST_DIRNAME}/input.txt"
    assert_output ''
    assert_equal "$(<"$TARGET_FILE")" "$expected"
}
