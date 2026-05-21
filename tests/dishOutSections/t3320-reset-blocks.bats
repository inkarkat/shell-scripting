#!/usr/bin/env bats

load fixture

@test "directly reset after first block" {
    run -0 dishOutSections --blocks 2 --reset "${BATS_TEST_DIRNAME}/numbers-lines.txt"
    assert_output $'one\ntwo'

    run -0 dishOutSections --blocks 2 "${BATS_TEST_DIRNAME}/numbers-lines.txt"
    assert_output $'one\ntwo'
}


@test "reset after three blocks" {
    run -0 dishOutSections --blocks 2 "${BATS_TEST_DIRNAME}/numbers-lines.txt"
    run -0 dishOutSections --blocks 2 "${BATS_TEST_DIRNAME}/numbers-lines.txt"
    run -0 dishOutSections --blocks 2 --reset "${BATS_TEST_DIRNAME}/numbers-lines.txt"
    run -0 dishOutSections --blocks 2 "${BATS_TEST_DIRNAME}/numbers-lines.txt"
    assert_output $'one\ntwo'
}

@test "seek to second block and reset" {
    run -0 dishOutSections --blocks 2 --seek 2 --reset "${BATS_TEST_DIRNAME}/numbers-lines.txt"
    assert_output $'three\nfour'

    run -0 dishOutSections --blocks 2 "${BATS_TEST_DIRNAME}/numbers-lines.txt"
    assert_output $'one\ntwo'
}

@test "seek beyond last block with wrap and reset" {
    run -0 dishOutSections --blocks 2 --seek $((BLOCK_NUM + 5)) --wrap --reset "${BATS_TEST_DIRNAME}/numbers-lines.txt"
    assert_output $'nine\nten'

    run -0 dishOutSections --blocks 2 "${BATS_TEST_DIRNAME}/numbers-lines.txt"
    assert_output $'one\ntwo'
}
