#!/usr/bin/env bats

load temp_file

@test "vanishing file gives error" {
    run -0 dishOutSections "${BATS_TMPDIR}/file.txt"
    assert_output $'first section\nwith some text'

    run -0 dishOutSections "${BATS_TMPDIR}/file.txt"
    assert_output 'second section, single line'

    rm -f -- "${BATS_TMPDIR}/file.txt"

    LC_ALL=C run -1 dishOutSections "${BATS_TMPDIR}/file.txt"
    assert_output -e 'fatal: cannot open file .* for reading'
}

@test "reappearing file restarts at first section" {
    run -0 dishOutSections "${BATS_TMPDIR}/file.txt"
    assert_output $'first section\nwith some text'

    run -0 dishOutSections "${BATS_TMPDIR}/file.txt"
    assert_output 'second section, single line'

    rm -f -- "${BATS_TMPDIR}/file.txt"

    LC_ALL=C run -1 dishOutSections "${BATS_TMPDIR}/file.txt"

    createFile

    run -0 dishOutSections "${BATS_TMPDIR}/file.txt"
    assert_output $'first section\nwith some text'
}

@test "reappearing file restarts at first section for all clients" {
    run -0 dishOutSections --for A "${BATS_TMPDIR}/file.txt"
    run -0 dishOutSections --for B "${BATS_TMPDIR}/file.txt"
    run -0 dishOutSections --for A "${BATS_TMPDIR}/file.txt"
    run -0 dishOutSections --for B "${BATS_TMPDIR}/file.txt"
    run -0 dishOutSections --for A "${BATS_TMPDIR}/file.txt"

    rm -f -- "${BATS_TMPDIR}/file.txt"

    LC_ALL=C run -1 dishOutSections "${BATS_TMPDIR}/file.txt"

    createFile

    run -0 dishOutSections --for A "${BATS_TMPDIR}/file.txt"
    assert_output $'first section\nwith some text'

    run -0 dishOutSections --for B "${BATS_TMPDIR}/file.txt"
    assert_output $'first section\nwith some text'
}
