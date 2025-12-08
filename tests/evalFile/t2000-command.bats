#!/usr/bin/env bats

load fixture

unset PASSWORD
export WHAT='test input'
export HOST_VAR=testhost
expected="$(cat <<'EOF'
This is a "test input" file on testhost with undefined. This escaping of $$$s for 'here' and "there".
//mymy\\ /single\ things
Just a * for /home/*
All on Linux, to be exact What do
I know?.
A literal $'\n' or $'nono'
EOF
)"

@test "processing of a single input file" {
    run -0 evalFile "${BATS_TEST_DIRNAME}/input.txt"
    assert_output "$expected"

}

@test "processing of a standard input specified as - FILE" {
    run -0 evalFile - < "${BATS_TEST_DIRNAME}/input.txt"
    assert_output "$expected"

}

@test "processing of a standard input when no arguments are given" {
    run -0 evalFile < "${BATS_TEST_DIRNAME}/input.txt"
    assert_output "$expected"

}

@test "processing of a multiple input files" {
    run -0 evalFile <(echo 'using process substitution for $WHAT') <(echo -e '$HOST_VAR\n${HOST_VAR}.')
    assert_output - <<'EOF'
using process substitution for test input
testhost
testhost.
EOF
}
