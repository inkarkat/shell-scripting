#!/usr/bin/env bats

load temp_file

@test "FILE is removed when no more sections are available" {
    run dishOutSections --delete-when-exhausted --seek 5 --wrap "${BATS_TMPDIR}/file.txt"
    assert_output 'fifth section after empty fourth section'

    run dishOutSections --delete-when-exhausted "${BATS_TMPDIR}/file.txt"
    assert_output 'last section'
    assert_file_exists "${BATS_TMPDIR}/file.txt"

    run -4 dishOutSections --delete-when-exhausted "${BATS_TMPDIR}/file.txt"
    assert_output ''
    assert_file_not_exists "${BATS_TMPDIR}/file.txt"
}
