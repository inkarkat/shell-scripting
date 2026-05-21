#!/usr/bin/env bats

load fixture

@test "print incrementing line counts with wrap around" {
    run -0 dishOutSections --lines --wrap "${BATS_TEST_DIRNAME}/fortunes-lines.txt"
    assert_output 'A ton of elephant is less than one elephant.'

    run -0 dishOutSections --lines --wrap "${BATS_TEST_DIRNAME}/fortunes-lines.txt"
    assert_output 'The problem of being faster than light is that you can only live in darkness.'

    run -0 dishOutSections --lines --wrap "${BATS_TEST_DIRNAME}/fortunes-lines.txt"
    assert_output "If money doesn't grow on trees, then why have banks branches?"

    run -0 dishOutSections --lines --wrap "${BATS_TEST_DIRNAME}/fortunes-lines.txt"
    assert_output 'A ton of elephant is less than one elephant.'

    run -0 dishOutSections --lines --wrap "${BATS_TEST_DIRNAME}/fortunes-lines.txt"
    assert_output 'The problem of being faster than light is that you can only live in darkness.'
}

@test "count beyond last line wraps around" {
    run -0 dishOutSections --lines --count $((LINE_NUM + 1)) --wrap "${BATS_TEST_DIRNAME}/numbers-lines.txt"
    assert_output 'one'

    run -0 dishOutSections --lines --count $((LINE_NUM + 5)) --wrap "${BATS_TEST_DIRNAME}/numbers-lines.txt"
    assert_output 'five'
}

@test "count beyond last line wraps around multiple times" {
    run -0 dishOutSections --lines --count $((2 * LINE_NUM + 1)) --wrap "${BATS_TEST_DIRNAME}/numbers-lines.txt"
    assert_output 'one'

    run -0 dishOutSections --lines --count $((42 * LINE_NUM + 5)) --wrap "${BATS_TEST_DIRNAME}/numbers-lines.txt"
    assert_output 'five'
}

@test "seek beyond last line wraps around" {
    run -0 dishOutSections --lines --seek $((LINE_NUM + 1)) --wrap "${BATS_TEST_DIRNAME}/numbers-lines.txt"
    assert_output 'one'

    run -0 dishOutSections --lines "${BATS_TEST_DIRNAME}/numbers-lines.txt"
    assert_output 'two'

    run -0 dishOutSections --lines --seek $((LINE_NUM + 5)) --wrap "${BATS_TEST_DIRNAME}/numbers-lines.txt"
    assert_output 'five'

    run -0 dishOutSections --lines "${BATS_TEST_DIRNAME}/numbers-lines.txt"
    assert_output 'six'
}

@test "seek beyond last line wraps around multiple times" {
    run -0 dishOutSections --lines --seek $((2 * LINE_NUM + 1)) --wrap "${BATS_TEST_DIRNAME}/numbers-lines.txt"
    assert_output 'one'

    run -0 dishOutSections --lines "${BATS_TEST_DIRNAME}/numbers-lines.txt"
    assert_output 'two'

    run -0 dishOutSections --lines --seek $((42 * LINE_NUM + 5)) --wrap "${BATS_TEST_DIRNAME}/numbers-lines.txt"
    assert_output 'five'

    run -0 dishOutSections --lines "${BATS_TEST_DIRNAME}/numbers-lines.txt"
    assert_output 'six'
}

@test "seek to last line causes increment to wrap around" {
    run -0 dishOutSections --lines --seek $LINE_NUM "${BATS_TEST_DIRNAME}/numbers-lines.txt"
    assert_output 'twelve'

    run -0 dishOutSections --lines --wrap "${BATS_TEST_DIRNAME}/numbers-lines.txt"
    assert_output 'one'
}
