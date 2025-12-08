#!/usr/bin/env bats

load fixture

@test "print incrementing counts until exhaustion" {
    run -0 dishOutSections "${BATS_TEST_DIRNAME}/input.txt"
    assert_output $'first section\nwith some text'

    run -0 dishOutSections "${BATS_TEST_DIRNAME}/input.txt"
    assert_output 'second section, single line'

    run -0 dishOutSections "${BATS_TEST_DIRNAME}/input.txt"
    assert_output - <<'EOF'
third section with empty lines


the end
EOF

    run -0 dishOutSections "${BATS_TEST_DIRNAME}/input.txt"
    assert_output ''

    run -0 dishOutSections "${BATS_TEST_DIRNAME}/input.txt"
    assert_output 'fifth section after empty fourth section'

    run -0 dishOutSections "${BATS_TEST_DIRNAME}/input.txt"
    assert_output 'last section'

    run -4 dishOutSections "${BATS_TEST_DIRNAME}/input.txt"
    assert_output ''
}
