#!/usr/bin/env bats

load temp_file

@test "FILE is removed when no more blocks are available" {
    run -0 dishOutSections --blocks 2 --delete-when-exhausted --seek 6 --wrap "${BATS_TMPDIR}/file.txt"
    assert_output $'---\nfifth section after empty fourth section'

    run -0 dishOutSections --blocks 2 --delete-when-exhausted "${BATS_TMPDIR}/file.txt"
    assert_output $'---\nlast section'
    assert_file_exists "${BATS_TMPDIR}/file.txt"

    run -4 dishOutSections --blocks 2 --delete-when-exhausted "${BATS_TMPDIR}/file.txt"
    assert_output ''
    assert_file_not_exists "${BATS_TMPDIR}/file.txt"
}
