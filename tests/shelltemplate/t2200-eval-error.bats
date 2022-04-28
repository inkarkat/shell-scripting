#!/usr/bin/env bats

load fixture

unset IS_NOT_DEFINED SHOULD_BE_DEFINED
export EMPTY=''

@test "eval error on undefined variable" {
    run shelltemplate "${BATS_TEST_DIRNAME}/undefinedError.txt"
    [ $status -eq 1 ]
    [[ "$output" =~ 'SHOULD_BE_DEFINED: parameter null or not set'$ ]]
}

@test "eval error on shell syntax error" {
    run shelltemplate "${BATS_TEST_DIRNAME}/syntaxError.txt"
    [ $status -ne 0 ]
    [[ "$output" =~ 'unexpected EOF while looking for matching `"'\' ]]
    [[ "$output" =~ 'syntax error: unexpected end of file'$ ]]
}

@test "eval error on undefined variable prevents override of existing target" {
    shelltemplate --target "$TARGET_FILE" "${BATS_TEST_DIRNAME}/input.txt"
    run shelltemplate --target "$TARGET_FILE" "${BATS_TEST_DIRNAME}/undefinedError.txt"
    [ $status -eq 1 ]
    [ "$(cat "$TARGET_FILE")" = "$expected" ]
}

@test "eval error on shell syntax error prevents override of existing target" {
    shelltemplate --target "$TARGET_FILE" "${BATS_TEST_DIRNAME}/input.txt"
    run shelltemplate --target "$TARGET_FILE" "${BATS_TEST_DIRNAME}/syntaxError.txt"
    [ $status -ne 0 ]
    [ "$(cat "$TARGET_FILE")" = "$expected" ]
}
