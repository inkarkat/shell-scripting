#!/usr/bin/env bats

load fixture

@test "print incrementing line counts until exhaustion" {
    for line in \
	one \
	two \
	three \
	four \
	five \
	six \
	seven \
	eight \
	nine \
	ten \
	eleven \
	twelve
    do
	run -0 dishOutSections --lines "${BATS_TEST_DIRNAME}/numbers-lines.txt"
	assert_output "$line"
    done

    run -4 dishOutSections --lines "${BATS_TEST_DIRNAME}/numbers-lines.txt"
    assert_output ''
}

@test "print incrementing line counts until exhaustion of process substitution via overridden filename" {
    DISHOUTSECTIONS_FILENAME=testinput run -0 dishOutSections --lines <(echo -e 'A\nB\nC')
    assert_output 'A'

    DISHOUTSECTIONS_FILENAME=testinput run -0 dishOutSections --lines <(echo -e 'A\nB\nC')
    assert_output 'B'

    DISHOUTSECTIONS_FILENAME=testinput run -0 dishOutSections --lines <(echo -e 'A\nB\nX')
    assert_output 'X'

    DISHOUTSECTIONS_FILENAME=testinput run -0 dishOutSections --lines <(echo -e 'A\nB\nX\nY\nZ')
    assert_output 'Y'

    DISHOUTSECTIONS_FILENAME=testinput run -0 dishOutSections --lines <(echo -e 'A\nB\nX\nY\nZ')
    assert_output 'Z'

    DISHOUTSECTIONS_FILENAME=testinput run -4 dishOutSections --lines <(echo -e 'A\nB\nX\nY\nZ')
    assert_output ''
}
