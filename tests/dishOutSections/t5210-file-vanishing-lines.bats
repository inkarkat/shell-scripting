#!/usr/bin/env bats

load temp_file

@test "vanishing file with lines gives error" {
    run -0 dishOutSections --lines "${BATS_TMPDIR}/file.txt"
    assert_output 'first section'

    run -0 dishOutSections --lines "${BATS_TMPDIR}/file.txt"
    assert_output 'with some text'

    rm -f -- "${BATS_TMPDIR}/file.txt"

    LC_ALL=C run -1 dishOutSections --lines "${BATS_TMPDIR}/file.txt"
    assert_output -e "can't read .*: No such file or directory"
}

@test "reappearing file restarts at first line" {
    run -0 dishOutSections --lines "${BATS_TMPDIR}/file.txt"
    assert_output 'first section'

    run -0 dishOutSections --lines "${BATS_TMPDIR}/file.txt"
    assert_output 'with some text'

    rm -f -- "${BATS_TMPDIR}/file.txt"

    LC_ALL=C run -1 dishOutSections --lines "${BATS_TMPDIR}/file.txt"

    createFile

    run -0 dishOutSections --lines "${BATS_TMPDIR}/file.txt"
    assert_output 'first section'
}
