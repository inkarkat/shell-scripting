#!/usr/bin/env bats

unset PASSWORD
export WHAT='test input'
export HOST_VAR=testhost
expected="$(cat <<EOF
This is a "test input" file on testhost with undefined.
All on $(uname), to be exact $(uname -o).
EOF
)"

export TARGET_FILE="${BATS_TMPDIR}/output.txt"
setup() {
    rm -f -- "$TARGET_FILE"
}

@test "input file to standard out" {
    run shelltemplate --file "${BATS_TEST_DIRNAME}/input.txt"
    [ $status -eq 0 ]
    [ "$output" = "$expected" ]
    [ ! -e "$TARGET_FILE" ]
}

@test "--file input file followed by target file" {
    run shelltemplate --file "${BATS_TEST_DIRNAME}/input.txt" "$TARGET_FILE"
    [ $status -eq 0 ]
    [ "$output" = "" ]
    [ "$(cat "$TARGET_FILE")" = "$expected" ]
}

@test "target file followed by input file" {
    run shelltemplate "$TARGET_FILE" "${BATS_TEST_DIRNAME}/input.txt"
    [ $status -eq 0 ]
    [ "$output" = "" ]
    [ "$(cat "$TARGET_FILE")" = "$expected" ]
}

@test "-- target file followed by input file" {
    run shelltemplate -- "$TARGET_FILE" "${BATS_TEST_DIRNAME}/input.txt"
    [ $status -eq 0 ]
    [ "$output" = "" ]
    [ "$(cat "$TARGET_FILE")" = "$expected" ]
}
