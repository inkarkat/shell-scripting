#!/usr/bin/env bats

load fixture

@test "print random existing counts" {
    runWithFullOutput -0 dishOutSections --count 1 "${BATS_TEST_DIRNAME}/input.txt"
    assert_output $'first section\nwith some text\n'

    runWithFullOutput -0 dishOutSections --count 2 "${BATS_TEST_DIRNAME}/input.txt"
    assert_output $'second section, single line\n'

    runWithFullOutput -0 dishOutSections --count 6 "${BATS_TEST_DIRNAME}/input.txt"
    assert_output $'last section\n'

    runWithFullOutput -0 dishOutSections --count 5 "${BATS_TEST_DIRNAME}/input.txt"
    assert_output $'fifth section after empty fourth section\n'

    runWithFullOutput -0 dishOutSections --count 3 "${BATS_TEST_DIRNAME}/input.txt"
    assert_output $'third section with empty lines\n\n\nthe end\n'

    runWithFullOutput -0 dishOutSections --count 4 "${BATS_TEST_DIRNAME}/input.txt"
    assert_output ''
}

@test "leading empty lines in a section are preserved" {
    runWithFullOutput -0 dishOutSections --count 2 <(cat <<'EOF'
first section
---


third line, first non-empty line of second section
third and last line
---
third section
EOF
)
    assert_output $'\n\nthird line, first non-empty line of second section\nthird and last line\n'
}

@test "trailing empty lines in a section are preserved" {
    runWithFullOutput -0 dishOutSections --count 2 <(cat <<'EOF'
first section
---
first line, first non-empty line of second section
second line, one non-empty line follows

---
third section
EOF
)
    assert_output $'first line, first non-empty line of second section\nsecond line, one non-empty line follows\n\n'
}

@test "printing of non-existing section returns 4" {
    run -4 dishOutSections --count 99 "${BATS_TEST_DIRNAME}/input.txt"
    assert_output ''
}

@test "printing of section of non-existing file returns 1" {
    LC_ALL=C run -1 dishOutSections --count 99 "${BATS_TEST_DIRNAME}/doesNotExist"
    assert_output -e 'fatal: cannot open file .* for reading'
}
