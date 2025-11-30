#!/usr/bin/env bats

load fixture

@test "print incrementing counts with wrap around" {
    run dishOutSections --wrap "${BATS_TEST_DIRNAME}/input.txt"
    assert_output $'first section\nwith some text'

    run dishOutSections --wrap "${BATS_TEST_DIRNAME}/input.txt"
    assert_output 'second section, single line'

    run dishOutSections --wrap "${BATS_TEST_DIRNAME}/input.txt"
    assert_output - <<'EOF'
third section with empty lines


the end
EOF

    run dishOutSections --wrap "${BATS_TEST_DIRNAME}/input.txt"
    assert_output ''

    run dishOutSections --wrap "${BATS_TEST_DIRNAME}/input.txt"
    assert_output 'fifth section after empty fourth section'

    run dishOutSections --wrap "${BATS_TEST_DIRNAME}/input.txt"
    assert_output 'last section'

    run dishOutSections --wrap "${BATS_TEST_DIRNAME}/input.txt"
    assert_output $'first section\nwith some text'

    run dishOutSections --wrap "${BATS_TEST_DIRNAME}/input.txt"
    assert_output 'second section, single line'
}

@test "count beyond last section wraps around" {
    run dishOutSections --count 7 --wrap "${BATS_TEST_DIRNAME}/input.txt"
    assert_output $'first section\nwith some text'

    run dishOutSections --count $((6 + 5)) --wrap "${BATS_TEST_DIRNAME}/input.txt"
    assert_output 'fifth section after empty fourth section'
}

@test "count beyond last section wraps around multiple times" {
    run dishOutSections --count $((2 * 6 + 1)) --wrap "${BATS_TEST_DIRNAME}/input.txt"
    assert_output $'first section\nwith some text'

    run dishOutSections --count $((42 * 6 + 5)) --wrap "${BATS_TEST_DIRNAME}/input.txt"
    assert_output 'fifth section after empty fourth section'
}

@test "seek beyond last section wraps around" {
    run dishOutSections --seek 7 --wrap "${BATS_TEST_DIRNAME}/input.txt"
    assert_output $'first section\nwith some text'

    run dishOutSections "${BATS_TEST_DIRNAME}/input.txt"
    assert_output 'second section, single line'

    run dishOutSections --seek $((6 + 5)) --wrap "${BATS_TEST_DIRNAME}/input.txt"
    assert_output 'fifth section after empty fourth section'

    run dishOutSections "${BATS_TEST_DIRNAME}/input.txt"
    assert_output 'last section'
}

@test "seek beyond last section wraps around multiple times" {
    run dishOutSections --seek $((2 * 6 + 1)) --wrap "${BATS_TEST_DIRNAME}/input.txt"
    assert_output $'first section\nwith some text'

    run dishOutSections "${BATS_TEST_DIRNAME}/input.txt"
    assert_output 'second section, single line'

    run dishOutSections --seek $((42 * 6 + 5)) --wrap "${BATS_TEST_DIRNAME}/input.txt"
    assert_output 'fifth section after empty fourth section'

    run dishOutSections "${BATS_TEST_DIRNAME}/input.txt"
    assert_output 'last section'
}

@test "seek to last section causes increment to wrap around" {
    run dishOutSections --seek 6 "${BATS_TEST_DIRNAME}/input.txt"
    assert_output 'last section'

    run dishOutSections --wrap "${BATS_TEST_DIRNAME}/input.txt"
    assert_output $'first section\nwith some text'
}
