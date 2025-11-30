#!/usr/bin/env bats

load fixture

@test "seek to random existing counts and print the successors" {
    run dishOutSections --seek 2 "${BATS_TEST_DIRNAME}/input.txt"
    assert_output 'second section, single line'

    run dishOutSections "${BATS_TEST_DIRNAME}/input.txt"
    assert_output - <<'EOF'
third section with empty lines


the end
EOF

    run dishOutSections --seek 4 "${BATS_TEST_DIRNAME}/input.txt"
    assert_output ''

    run dishOutSections --seek 1 "${BATS_TEST_DIRNAME}/input.txt"
    assert_output $'first section\nwith some text'

    run dishOutSections "${BATS_TEST_DIRNAME}/input.txt"
    assert_output 'second section, single line'
}

@test "seek to last section stops further printing" {
    run dishOutSections --seek 6 "${BATS_TEST_DIRNAME}/input.txt"
    assert_output 'last section'

    run -4 dishOutSections "${BATS_TEST_DIRNAME}/input.txt"
    assert_output ''
}
