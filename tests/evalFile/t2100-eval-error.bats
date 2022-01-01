#!/usr/bin/env bats

unset IS_NOT_DEFINED SHOULD_BE_DEFINED
export EMPTY=''

@test "eval error on undefined variable" {
    run evalFile <<'EOF'
This ${IS_NOT_DEFINED:-defaulted} variable is still fine.
But ${SHOULD_BE_DEFINED:?} breaks the evaluation.
${EMPTY?} would, too.
EOF
    [ $status -eq 1 ]
    [[ "$output" =~ 'SHOULD_BE_DEFINED: parameter null or not set'$ ]]
}

@test "eval error on shell syntax error" {
    run evalFile <<'EOF'
This ${IS_NOT_DEFINED:-defaulted} variable is still fine.
But ${shouldBeClosed breaks the evaluation.
${EMPTY?} would, too.
EOF
    [ $status -eq 1 ]
    [[ "$output" =~ 'unexpected EOF while looking for matching `"'\' ]]
    [[ "$output" =~ 'syntax error: unexpected end of file'$ ]]
}
