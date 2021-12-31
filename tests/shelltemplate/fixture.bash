#!/bin/bash

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
