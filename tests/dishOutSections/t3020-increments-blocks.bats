#!/usr/bin/env bats

load fixture

@test "print incrementing block counts until exhaustion" {
    for block in \
	$'one\ntwo' \
	$'three\nfour' \
	$'five\nsix' \
	$'seven\neight' \
	$'nine\nten' \
	$'eleven\ntwelve'
    do
	run -0 dishOutSections --blocks 2 "${BATS_TEST_DIRNAME}/numbers-lines.txt"
	assert_output "$block"
    done

    run -4 dishOutSections --blocks 2 "${BATS_TEST_DIRNAME}/numbers-lines.txt"
    assert_output ''
}
