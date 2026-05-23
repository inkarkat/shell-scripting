#!/usr/bin/env bats

load fixture

@test "empty stdin input exits with 4" {
    run -4 dishOutSections - <<<''
    assert_output ''
}

@test "iteration of stdin sections" {
    run -0 dishOutSections - < "${BATS_TEST_DIRNAME}/input.txt"
    assert_output $'first section\nwith some text'

    run -0 dishOutSections - < "${BATS_TEST_DIRNAME}/input.txt"
    assert_output 'second section, single line'
}

@test "iteration of stdin count beyond last section wraps around" {
    run -0 dishOutSections --count $((SECTION_NUM + 1)) --wrap - < "${BATS_TEST_DIRNAME}/input.txt"
    assert_output $'first section\nwith some text'
}

readonly ANIMALS=$'aardvark\nbuffalo\n---\ncat\n---\ndog'
readonly DISHES=$'apple pie\nbanana split\n---\ncarrot cake\n---\ndoughnut'

@test "iteration of stdin is based on contents" {
    run -0 dishOutSections - <<<"$ANIMALS"
    assert_output $'aardvark\nbuffalo'

    run -0 dishOutSections - <<<"$ANIMALS"
    assert_output 'cat'

    run -0 dishOutSections - <<<"$DISHES"
    assert_output $'apple pie\nbanana split'

    run -0 dishOutSections - <<<"$ANIMALS"
    assert_output 'dog'

    run -0 dishOutSections - <<<"$DISHES"
    assert_output 'carrot cake'

    run -4 dishOutSections - <<<"$ANIMALS"
    assert_output ''

    run -0 dishOutSections - <<<"$DISHES"
    assert_output 'doughnut'

    run -4 dishOutSections - <<<"$DISHES"
    assert_output ''
}

@test "iteration tracking of stdin can be overridden" {
    export DISHOUTSECTIONS_FILENAME=animals-and-dishes

    run -0 dishOutSections - <<<"$ANIMALS"
    assert_output $'aardvark\nbuffalo'

    run -0 dishOutSections - <<<"$DISHES"
    assert_output 'carrot cake'

    run -0 dishOutSections - <<<"$ANIMALS"
    assert_output 'dog'

    run -4 dishOutSections - <<<"$DISHES"
    assert_output ''
}
