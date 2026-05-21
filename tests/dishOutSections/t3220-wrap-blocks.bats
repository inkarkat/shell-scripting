#!/usr/bin/env bats

load fixture

@test "print incrementing block counts with wrap around" {
    run -0 dishOutSections --blocks 2 --wrap "${BATS_TEST_DIRNAME}/fortunes-blocks.txt"
    assert_output - <<'EOF'
My teacher told me years ago not to worry about spelling because in the future
there will be autocorrect. And for that I am eternally grapefruit.
EOF

    run -0 dishOutSections --blocks 2 --wrap "${BATS_TEST_DIRNAME}/fortunes-blocks.txt"
    assert_output - <<'EOF'
There's a fine line between a numerator and a denominator.
Only a fraction of people will find this funny.
EOF

    run -0 dishOutSections --blocks 2 --wrap "${BATS_TEST_DIRNAME}/fortunes-blocks.txt"
    assert_output - <<'EOF'
I don't know how many cookies it takes to be happy,
but so far it's not twenty seven.
EOF

    run -0 dishOutSections --blocks 2 --wrap "${BATS_TEST_DIRNAME}/fortunes-blocks.txt"
    assert_output - <<'EOF'
My teacher told me years ago not to worry about spelling because in the future
there will be autocorrect. And for that I am eternally grapefruit.
EOF

    run -0 dishOutSections --blocks 2 --wrap "${BATS_TEST_DIRNAME}/fortunes-blocks.txt"
    assert_output - <<'EOF'
There's a fine line between a numerator and a denominator.
Only a fraction of people will find this funny.
EOF
}

@test "print incrementing block counts on incomplete last block with wrap around" {
    run -0 dishOutSections --blocks 5 --wrap "${BATS_TEST_DIRNAME}/numbers-lines.txt"
    assert_output $'one\ntwo\nthree\nfour\nfive'

    run -0 dishOutSections --blocks 5 --wrap "${BATS_TEST_DIRNAME}/numbers-lines.txt"
    assert_output $'six\nseven\neight\nnine\nten'

    run -0 dishOutSections --blocks 5 --wrap "${BATS_TEST_DIRNAME}/numbers-lines.txt"
    assert_output $'eleven\ntwelve'

    run -0 dishOutSections --blocks 5 --wrap "${BATS_TEST_DIRNAME}/numbers-lines.txt"
    assert_output $'one\ntwo\nthree\nfour\nfive'
}

@test "count beyond last block wraps around" {
    run -0 dishOutSections --blocks 2 --count $((BLOCK_NUM + 1)) --wrap "${BATS_TEST_DIRNAME}/numbers-lines.txt"
    assert_output $'one\ntwo'

    run -0 dishOutSections --blocks 2 --count $((BLOCK_NUM + 5)) --wrap "${BATS_TEST_DIRNAME}/numbers-lines.txt"
    assert_output $'nine\nten'
}

@test "count beyond last block wraps around multiple times" {
    run -0 dishOutSections --blocks 2 --count $((2 * BLOCK_NUM + 1)) --wrap "${BATS_TEST_DIRNAME}/numbers-lines.txt"
    assert_output $'one\ntwo'

    run -0 dishOutSections --blocks 2 --count $((42 * BLOCK_NUM + 5)) --wrap "${BATS_TEST_DIRNAME}/numbers-lines.txt"
    assert_output $'nine\nten'
}

@test "seek beyond last block wraps around" {
    run -0 dishOutSections --blocks 2 --seek $((BLOCK_NUM + 1)) --wrap "${BATS_TEST_DIRNAME}/numbers-lines.txt"
    assert_output $'one\ntwo'

    run -0 dishOutSections --blocks 2 "${BATS_TEST_DIRNAME}/numbers-lines.txt"
    assert_output $'three\nfour'

    run -0 dishOutSections --blocks 2 --seek $((BLOCK_NUM + 5)) --wrap "${BATS_TEST_DIRNAME}/numbers-lines.txt"
    assert_output $'nine\nten'

    run -0 dishOutSections --blocks 2 "${BATS_TEST_DIRNAME}/numbers-lines.txt"
    assert_output $'eleven\ntwelve'
}

@test "seek beyond last block wraps around multiple times" {
    run -0 dishOutSections --blocks 2 --seek $((2 * BLOCK_NUM + 1)) --wrap "${BATS_TEST_DIRNAME}/numbers-lines.txt"
    assert_output $'one\ntwo'

    run -0 dishOutSections --blocks 2 "${BATS_TEST_DIRNAME}/numbers-lines.txt"
    assert_output $'three\nfour'

    run -0 dishOutSections --blocks 2 --seek $((42 * BLOCK_NUM + 5)) --wrap "${BATS_TEST_DIRNAME}/numbers-lines.txt"
    assert_output $'nine\nten'

    run -0 dishOutSections --blocks 2 "${BATS_TEST_DIRNAME}/numbers-lines.txt"
    assert_output $'eleven\ntwelve'
}

@test "seek to last block causes increment to wrap around" {
    run -0 dishOutSections --blocks 2 --seek $BLOCK_NUM "${BATS_TEST_DIRNAME}/numbers-lines.txt"
    assert_output $'eleven\ntwelve'

    run -0 dishOutSections --blocks 2 --wrap "${BATS_TEST_DIRNAME}/numbers-lines.txt"
    assert_output $'one\ntwo'
}
