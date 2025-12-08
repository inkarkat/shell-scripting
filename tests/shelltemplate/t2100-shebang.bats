#!/usr/bin/env bats

load fixture

@test "shebang to standard out" {
    run -0 "${BATS_TEST_DIRNAME}/shebang-input"
    assert_output "$expected"
    assert_not_exists "$TARGET_FILE"
}

@test "shebang to passed target file" {
    run -0 "${BATS_TEST_DIRNAME}/shebang-input" "$TARGET_FILE"
    assert_output ''
    assert_equal "$(<"$TARGET_FILE")" "$expected"
}

@test "shebang to passed --target file" {
    run -0 "${BATS_TEST_DIRNAME}/shebang-input" --target "$TARGET_FILE"
    assert_output ''
    assert_equal "$(<"$TARGET_FILE")" "$expected"
}

@test "shebang with two passed files gives error and usage" {
    run -2 "${BATS_TEST_DIRNAME}/shebang-input" "$TARGET_FILE" additional.txt
    assert_line -n -1 -e '^Usage:'
    assert_not_exists "$TARGET_FILE"
}

@test "shebang to embedded target file" {
    run -0 "${BATS_TEST_DIRNAME}/shebang-output"
    assert_output ''
    assert_equal "$(</tmp/output.txt)" "$expected"
}

@test "shebang to embedded target file with passed file gives error and usage" {
    run -2 "${BATS_TEST_DIRNAME}/shebang-output" additional.txt
    assert_line -n -1 -e '^Usage:'
    assert_not_exists "$TARGET_FILE"
}
