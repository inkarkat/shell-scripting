#!/usr/bin/env bats

load fixture

@test "invalid base-type prints usage error" {
    run -3 dishOutSections --base-type doesNotExist "${BATS_TEST_DIRNAME}/input.txt"
    assert_line -n 0 'ERROR: Invalid base-type "doesNotExist".'
    assert_line -n 1 -e '^Usage:'
}
