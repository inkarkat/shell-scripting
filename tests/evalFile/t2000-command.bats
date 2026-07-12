#!/usr/bin/env bats

load fixture

unset PASSWORD
export WHAT='test input'
export HOST_VAR=testhost

@test "processing of a single input file" {
    run -0 evalFile "${BATS_TEST_DIRNAME}/input.txt"
    assert_output - < "${BATS_TEST_DIRNAME}/expected.txt"
}

@test "processing of a standard input specified as - FILE" {
    run -0 evalFile - < "${BATS_TEST_DIRNAME}/input.txt"
    assert_output - < "${BATS_TEST_DIRNAME}/expected.txt"
}

@test "processing of a standard input when no arguments are given" {
    run -0 evalFile < "${BATS_TEST_DIRNAME}/input.txt"
    assert_output - < "${BATS_TEST_DIRNAME}/expected.txt"
}

@test "processing of a multiple input files" {
    run -0 evalFile <(echo 'using process substitution for $WHAT') <(echo -e '$HOST_VAR\n${HOST_VAR}.')
    assert_output - <<'EOF'
using process substitution for test input
testhost
testhost.
EOF
}
