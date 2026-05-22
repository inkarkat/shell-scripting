#!/usr/bin/env bats

load fixture

@test "directly seek to 1 again after first section" {
    run -0 dishOutSections --seek-after 1 "${BATS_TEST_DIRNAME}/input.txt"
    assert_output $'first section\nwith some text'

    run -0 dishOutSections "${BATS_TEST_DIRNAME}/input.txt"
    assert_output $'first section\nwith some text'
}

@test "seek to first section after three sections" {
    run -0 dishOutSections "${BATS_TEST_DIRNAME}/input.txt"
    run -0 dishOutSections "${BATS_TEST_DIRNAME}/input.txt"
    run -0 dishOutSections --seek-after 1 "${BATS_TEST_DIRNAME}/input.txt"
    run -0 dishOutSections "${BATS_TEST_DIRNAME}/input.txt"
    assert_output $'first section\nwith some text'
}

@test "seek to second section and seek after it to section 5" {
    run -0 dishOutSections --seek 2 --seek-after 5 "${BATS_TEST_DIRNAME}/input.txt"
    assert_output 'second section, single line'

    run -0 dishOutSections "${BATS_TEST_DIRNAME}/input.txt"
    assert_output 'fifth section after empty fourth section'
}

@test "seek beyond last section with wrap and seek after" {
    run -0 dishOutSections --seek $((SECTION_NUM + 5)) --wrap --seek-after 2 "${BATS_TEST_DIRNAME}/input.txt"
    assert_output 'fifth section after empty fourth section'

    run -0 dishOutSections "${BATS_TEST_DIRNAME}/input.txt"
    assert_output 'second section, single line'
}

@test "seek beyond last section still executes seek after" {
    run -4 dishOutSections --seek $((SECTION_NUM + 1)) --seek-after 2 "${BATS_TEST_DIRNAME}/input.txt"
    assert_output ''

    run -0 dishOutSections "${BATS_TEST_DIRNAME}/input.txt"
    assert_output 'second section, single line'
}


@test "seek to second section and seek after it three sections ahead" {
    run -0 dishOutSections --seek 2 --seek-after +3 "${BATS_TEST_DIRNAME}/input.txt"
    assert_output 'second section, single line'

    run -0 dishOutSections "${BATS_TEST_DIRNAME}/input.txt"
    assert_output 'fifth section after empty fourth section'
}

@test "seek to second section and seek after it one section back" {
    run -0 dishOutSections --seek 2 --seek-after -1 "${BATS_TEST_DIRNAME}/input.txt"
    assert_output 'second section, single line'

    run -0 dishOutSections "${BATS_TEST_DIRNAME}/input.txt"
    assert_output $'first section\nwith some text'
}

@test "seek to second section and seek after by zero to stay at same section" {
    run -0 dishOutSections --seek 2 --seek-after +0 "${BATS_TEST_DIRNAME}/input.txt"
    assert_output 'second section, single line'

    run -0 dishOutSections "${BATS_TEST_DIRNAME}/input.txt"
    assert_output 'second section, single line'
}

@test "seek to second section and seek after by +1 which is the same as the default increment" {
    run -0 dishOutSections --seek 2 --seek-after +1 "${BATS_TEST_DIRNAME}/input.txt"
    assert_output 'second section, single line'

    run -0 dishOutSections "${BATS_TEST_DIRNAME}/input.txt"
    assert_output - <<'EOF'
third section with empty lines


the end
EOF
}

@test "seek to second section and seek after it so many sections back that exhausts the file" {
    for count in -2 -10 -9999
    do
	run -0 dishOutSections --seek 2 --seek-after $count "${BATS_TEST_DIRNAME}/input.txt" \
	    && assert_output 'second section, single line' \
	    || fail "$count"

	run -4 dishOutSections "${BATS_TEST_DIRNAME}/input.txt" \
	    && assert_output '' \
	    || fail "$count"
    done
}

@test "seek to second section and seek after it so many sections forward that exhausts the file" {
    for count in +5 +10 +9999
    do
	run -0 dishOutSections --seek 2 --seek-after $count "${BATS_TEST_DIRNAME}/input.txt" \
	    && assert_output 'second section, single line' \
	    || fail "$count"

	run -4 dishOutSections "${BATS_TEST_DIRNAME}/input.txt" \
	    && assert_output '' \
	    || fail "$count"
    done
}
