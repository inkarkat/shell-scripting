#!/usr/bin/env bats

load fixture

@test "dedicated dishOutPairs command works" {
    runWithFullOutput -0 dishOutPairs --count 1 "${BATS_TEST_DIRNAME}/numbers-lines.txt"
    assert_output $'one\ntwo\n'

    runWithFullOutput -0 dishOutPairs --count 2 "${BATS_TEST_DIRNAME}/numbers-lines.txt"
    assert_output $'three\nfour\n'

    runWithFullOutput -0 dishOutPairs --count 6 "${BATS_TEST_DIRNAME}/numbers-lines.txt"
    assert_output $'eleven\ntwelve\n'

    runWithFullOutput -0 dishOutPairs --count 4 "${BATS_TEST_DIRNAME}/input.txt"
    assert_output $'\n\n'
}
