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
