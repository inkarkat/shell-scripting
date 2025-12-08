#!/bin/bash

bats_require_minimum_version 1.5.0
bats_load_library bats-support
bats_load_library bats-assert
bats_load_library bats-file

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
    ln -s -- "$(command -v shelltemplate)" /tmp/shelltemplate
}

teardown() {
    rm -f -- /tmp/shelltemplate
}
