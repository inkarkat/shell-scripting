#!/usr/bin/env bats

load fixture

@test "print random existing 2-line block counts" {
    runWithFullOutput -0 dishOutSections --blocks 2 --count 1 "${BATS_TEST_DIRNAME}/numbers-lines.txt"
    assert_output $'one\ntwo\n'

    runWithFullOutput -0 dishOutSections --blocks 2 --count 2 "${BATS_TEST_DIRNAME}/numbers-lines.txt"
    assert_output $'three\nfour\n'

    runWithFullOutput -0 dishOutSections --blocks 2 --count 6 "${BATS_TEST_DIRNAME}/numbers-lines.txt"
    assert_output $'eleven\ntwelve\n'

    runWithFullOutput -0 dishOutSections --blocks 2 --count 4 "${BATS_TEST_DIRNAME}/input.txt"
    assert_output $'\n\n'
}

@test "leading empty lines in a block are preserved" {
    cat >"${BATS_TMPDIR}/file.txt" <<'EOF'
the
first
block


third line, first non-empty line of second block
the
third
block
EOF
    runWithFullOutput -0 dishOutSections --blocks 3 --count 2 "${BATS_TMPDIR}/file.txt"
    assert_output $'\n\nthird line, first non-empty line of second block\n'
}

@test "trailing empty lines in a block are preserved" {
    cat >"${BATS_TMPDIR}/file.txt" <<'EOF'
first
block
first line of second block, one non-empty line follows

third
block
EOF
    runWithFullOutput -0 dishOutSections --blocks 2 --count 2 "${BATS_TMPDIR}/file.txt"
    assert_output $'first line of second block, one non-empty line follows\n\n'
}

@test "print random existing 3-line block counts" {
    run -0 dishOutSections --blocks 3 --count 1 "${BATS_TEST_DIRNAME}/numbers-lines.txt"
    assert_output $'one\ntwo\nthree'

    run -0 dishOutSections --blocks 3 --count 2 "${BATS_TEST_DIRNAME}/numbers-lines.txt"
    assert_output $'four\nfive\nsix'

    run -0 dishOutSections --blocks 3 --count 4 "${BATS_TEST_DIRNAME}/numbers-lines.txt"
    assert_output $'ten\neleven\ntwelve'
}

@test "print random existing 5-line block counts" {
    run -0 dishOutSections --blocks 5 --count 1 "${BATS_TEST_DIRNAME}/numbers-lines.txt"
    assert_output $'one\ntwo\nthree\nfour\nfive'

    run -0 dishOutSections --blocks 5 --count 2 "${BATS_TEST_DIRNAME}/numbers-lines.txt"
    assert_output $'six\nseven\neight\nnine\nten'

    run -0 dishOutSections --blocks 5 --count 3 "${BATS_TEST_DIRNAME}/numbers-lines.txt"
    assert_output $'eleven\ntwelve'
}

@test "print existing 11-line block counts" {
    run -0 dishOutSections --blocks 11 --count 1 "${BATS_TEST_DIRNAME}/numbers-lines.txt"
    assert_output $'one\ntwo\nthree\nfour\nfive\nsix\nseven\neight\nnine\nten\neleven'

    runWithFullOutput -0 dishOutSections --blocks 11 --count 2 "${BATS_TEST_DIRNAME}/numbers-lines.txt"
    assert_output $'twelve\n'

    runWithFullOutput -4 dishOutSections --blocks 11 --count 3 "${BATS_TEST_DIRNAME}/numbers-lines.txt"
    assert_output ''
}

@test "print existing 15-line block counts" {
    runWithFullOutput -0 dishOutSections --blocks 15 --count 1 "${BATS_TEST_DIRNAME}/numbers-lines.txt"
    assert_output $'one\ntwo\nthree\nfour\nfive\nsix\nseven\neight\nnine\nten\neleven\ntwelve\n'

    runWithFullOutput -4 dishOutSections --blocks 15 --count 2 "${BATS_TEST_DIRNAME}/numbers-lines.txt"
    assert_output ''
}

@test "printing of non-existing block returns 4" {
    run -4 dishOutSections --blocks 2 --count 99 "${BATS_TEST_DIRNAME}/numbers-lines.txt"
    assert_output ''
}

@test "printing of block of non-existing file returns 1" {
    LC_ALL=C run -1 dishOutSections --blocks 2 --count 99 "${BATS_TEST_DIRNAME}/doesNotExist"
    assert_output -e "can't read .*: No such file or directory"
}
