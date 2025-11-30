#!/usr/bin/env bats

load fixture

@test "print random existing counts" {
    run dishOutSections --count 1 "${BATS_TEST_DIRNAME}/input.txt"
    assert_output $'first section\nwith some text'

    run dishOutSections --count 2 "${BATS_TEST_DIRNAME}/input.txt"
    assert_output 'second section, single line'

    run dishOutSections --count 6 "${BATS_TEST_DIRNAME}/input.txt"
    assert_output 'last section'

    run dishOutSections --count 5 "${BATS_TEST_DIRNAME}/input.txt"
    assert_output 'fifth section after empty fourth section'

    run dishOutSections --count 3 "${BATS_TEST_DIRNAME}/input.txt"
    assert_output - <<'EOF'
third section with empty lines


the end
EOF

    run dishOutSections --count 4 "${BATS_TEST_DIRNAME}/input.txt"
    assert_output ''
}

@test "printing of non-existing section returns 4" {
    run -4 dishOutSections --count 99 "${BATS_TEST_DIRNAME}/input.txt"
    assert_output ''
}

@test "printing of non-existing file returns 1" {
    LC_ALL=C run -1 dishOutSections --count 99 "${BATS_TEST_DIRNAME}/doesNotExist"
    assert_output -e 'fatal: cannot open file .* for reading: No such file or directory'
}
