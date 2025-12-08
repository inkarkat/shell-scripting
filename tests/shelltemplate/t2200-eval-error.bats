#!/usr/bin/env bats

load fixture

unset IS_NOT_DEFINED SHOULD_BE_DEFINED
export EMPTY=''

@test "eval error on undefined variable" {
    run -1 shelltemplate "${BATS_TEST_DIRNAME}/undefinedError.txt"
    assert_output -e 'SHOULD_BE_DEFINED: parameter null or not set'$
}

@test "eval error on shell syntax error" {
    run ! shelltemplate "${BATS_TEST_DIRNAME}/syntaxError.txt"
    assert_output -e 'unexpected EOF while looking for matching `"'\'
}

@test "eval error on undefined variable prevents override of existing target" {
    shelltemplate --target "$TARGET_FILE" "${BATS_TEST_DIRNAME}/input.txt"
    run -1 shelltemplate --target "$TARGET_FILE" "${BATS_TEST_DIRNAME}/undefinedError.txt"
    assert_equal "$(<"$TARGET_FILE")" "$expected"
}

@test "eval error on shell syntax error prevents override of existing target" {
    shelltemplate --target "$TARGET_FILE" "${BATS_TEST_DIRNAME}/input.txt"
    run ! shelltemplate --target "$TARGET_FILE" "${BATS_TEST_DIRNAME}/syntaxError.txt"
    assert_equal "$(<"$TARGET_FILE")" "$expected"
}
