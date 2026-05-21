#!/usr/bin/env bats

load fixture

@test "seek to random existing block counts and print the successors" {
    run -0 dishOutSections --blocks 2 --seek 2 "${BATS_TEST_DIRNAME}/numbers-lines.txt"
    assert_output $'three\nfour'

    run -0 dishOutSections --blocks 2 "${BATS_TEST_DIRNAME}/numbers-lines.txt"
    assert_output $'five\nsix'

    run -0 dishOutSections --blocks 2 --seek 4 "${BATS_TEST_DIRNAME}/numbers-lines.txt"
    assert_output $'seven\neight'

    run -0 dishOutSections --blocks 2 --seek 1 "${BATS_TEST_DIRNAME}/numbers-lines.txt"
    assert_output $'one\ntwo'

    run -0 dishOutSections --blocks 2 "${BATS_TEST_DIRNAME}/numbers-lines.txt"
    assert_output $'three\nfour'
}

@test "seek to last block stops further printing" {
    run -0 dishOutSections --blocks 2 --seek 6 "${BATS_TEST_DIRNAME}/numbers-lines.txt"
    assert_output $'eleven\ntwelve'

    run -4 dishOutSections --blocks 2 "${BATS_TEST_DIRNAME}/numbers-lines.txt"
    assert_output ''
}
