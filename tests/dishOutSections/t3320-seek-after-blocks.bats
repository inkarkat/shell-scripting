#!/usr/bin/env bats

load fixture

@test "directly seek to 1 again after first block" {
    run -0 dishOutSections --blocks 2 --seek-after 1 "${BATS_TEST_DIRNAME}/numbers-lines.txt"
    assert_output $'one\ntwo'

    run -0 dishOutSections --blocks 2 "${BATS_TEST_DIRNAME}/numbers-lines.txt"
    assert_output $'one\ntwo'
}

@test "seek to first block after three blocks" {
    run -0 dishOutSections --blocks 2 "${BATS_TEST_DIRNAME}/numbers-lines.txt"
    run -0 dishOutSections --blocks 2 "${BATS_TEST_DIRNAME}/numbers-lines.txt"
    run -0 dishOutSections --blocks 2 --seek-after 1 "${BATS_TEST_DIRNAME}/numbers-lines.txt"
    run -0 dishOutSections --blocks 2 "${BATS_TEST_DIRNAME}/numbers-lines.txt"
    assert_output $'one\ntwo'
}

@test "seek to second block and seek after it to block 5" {
    run -0 dishOutSections --blocks 2 --seek 2 --seek-after 5 "${BATS_TEST_DIRNAME}/numbers-lines.txt"
    assert_output $'three\nfour'

    run -0 dishOutSections --blocks 2 "${BATS_TEST_DIRNAME}/numbers-lines.txt"
    assert_output $'nine\nten'
}

@test "seek beyond last block with wrap and seek after" {
    run -0 dishOutSections --blocks 2 --seek $((BLOCK_NUM + 5)) --wrap --seek-after 2 "${BATS_TEST_DIRNAME}/numbers-lines.txt"
    assert_output $'nine\nten'

    run -0 dishOutSections --blocks 2 "${BATS_TEST_DIRNAME}/numbers-lines.txt"
    assert_output $'three\nfour'
}
