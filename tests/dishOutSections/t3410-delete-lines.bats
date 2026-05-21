#!/usr/bin/env bats

load temp_file

@test "FILE is removed when no more lines are available" {
    run -0 dishOutSections --lines --delete-when-exhausted --seek 13 --wrap "${BATS_TMPDIR}/file.txt"
    assert_output '---'

    run -0 dishOutSections --lines --delete-when-exhausted "${BATS_TMPDIR}/file.txt"
    assert_output 'last section'
    assert_file_exists "${BATS_TMPDIR}/file.txt"

    run -4 dishOutSections --lines --delete-when-exhausted "${BATS_TMPDIR}/file.txt"
    assert_output ''
    assert_file_not_exists "${BATS_TMPDIR}/file.txt"
}
