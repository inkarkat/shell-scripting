#!/usr/bin/env bats

load fixture

@test "env shebang to standard out" {
    run -0 "${BATS_TEST_DIRNAME}/env-shebang"
    assert_output "$expected"
    assert_not_exists "$TARGET_FILE"
}

@test "env shebang to passed target file" {
    run -0 "${BATS_TEST_DIRNAME}/env-shebang" "$TARGET_FILE"
    assert_output ''
    assert_equal "$(<"$TARGET_FILE")" "$expected"
}

@test "env shebang to passed --target file" {
    run -0 "${BATS_TEST_DIRNAME}/env-shebang" --target "$TARGET_FILE"
    assert_output ''
    assert_equal "$(<"$TARGET_FILE")" "$expected"
}

@test "env shebang with two passed files gives error and usage" {
    run -2 "${BATS_TEST_DIRNAME}/env-shebang" "$TARGET_FILE" additional.txt
    assert_line -n -1 -e '^Usage:'
    assert_not_exists "$TARGET_FILE"
}
