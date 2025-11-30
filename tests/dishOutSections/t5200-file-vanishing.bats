#!/usr/bin/env bats

load temp_file

@test "vanishing file gives error" {
    run dishOutSections "${BATS_TMPDIR}/file.txt"
    assert_output $'first section\nwith some text'

    run dishOutSections "${BATS_TMPDIR}/file.txt"
    assert_output 'second section, single line'

    rm -f -- "${BATS_TMPDIR}/file.txt"

    LC_ALL=C run -1 dishOutSections "${BATS_TMPDIR}/file.txt"
    assert_output -e 'fatal: cannot open file .* for reading: No such file or directory'
}

@test "reappearing file restarts at first section" {
    run dishOutSections "${BATS_TMPDIR}/file.txt"
    assert_output $'first section\nwith some text'

    run dishOutSections "${BATS_TMPDIR}/file.txt"
    assert_output 'second section, single line'

    rm -f -- "${BATS_TMPDIR}/file.txt"

    LC_ALL=C run -1 dishOutSections "${BATS_TMPDIR}/file.txt"

    createFile

    run dishOutSections "${BATS_TMPDIR}/file.txt"
    assert_output $'first section\nwith some text'
}

@test "reappearing file restarts at first section for all clients" {
    run dishOutSections --for A "${BATS_TMPDIR}/file.txt"
    run dishOutSections --for B "${BATS_TMPDIR}/file.txt"
    run dishOutSections --for A "${BATS_TMPDIR}/file.txt"
    run dishOutSections --for B "${BATS_TMPDIR}/file.txt"
    run dishOutSections --for A "${BATS_TMPDIR}/file.txt"

    rm -f -- "${BATS_TMPDIR}/file.txt"

    LC_ALL=C run -1 dishOutSections "${BATS_TMPDIR}/file.txt"

    createFile

    run dishOutSections --for A "${BATS_TMPDIR}/file.txt"
    assert_output $'first section\nwith some text'

    run dishOutSections --for B "${BATS_TMPDIR}/file.txt"
    assert_output $'first section\nwith some text'
}
