#!/usr/bin/env bats

load fixture

@test "print random existing line counts" {
    runWithFullOutput -0 dishOutSections --lines --count 1 "${BATS_TEST_DIRNAME}/numbers-lines.txt"
    assert_output $'one\n'

    runWithFullOutput -0 dishOutSections --lines --count 2 "${BATS_TEST_DIRNAME}/numbers-lines.txt"
    assert_output $'two\n'

    runWithFullOutput -0 dishOutSections --lines --count 12 "${BATS_TEST_DIRNAME}/numbers-lines.txt"
    assert_output $'twelve\n'

    runWithFullOutput -0 dishOutSections --lines --count 7 "${BATS_TEST_DIRNAME}/input.txt"
    assert_output $'\n'
}

@test "printing of non-existing line returns 4" {
    run -4 dishOutSections --lines --count 99 "${BATS_TEST_DIRNAME}/numbers-lines.txt"
    assert_output ''
}

@test "printing of line of non-existing file returns 1" {
    LC_ALL=C run -1 dishOutSections --lines --count 99 "${BATS_TEST_DIRNAME}/doesNotExist"
    assert_output -e "can't read .*: No such file or directory"
}
