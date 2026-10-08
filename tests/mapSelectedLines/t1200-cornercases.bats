#!/usr/bin/env bats

load fixture

@test "no input exits with 99" {
    run -99 mapSelectedLines --select-line-number 1 "${UPPERCASE_COMMAND[@]}" </dev/null
    assert_output ''
}

@test "no selected line numbers exits with 4" {
    run -4 mapSelectedLines --select-line-number 5 "${UPPERCASE_COMMAND[@]}" <<<"$INPUT"
    assert_output ''
}

@test "no such line exits with 4" {
    run -4 mapSelectedLines --select-line doesNotExist "${UPPERCASE_COMMAND[@]}" <<<"$INPUT"
    assert_output ''
}

@test "no matching PATTERN exits with 4" {
    run -4 mapSelectedLines --select-match 'does.*Not.*Exist' "${UPPERCASE_COMMAND[@]}" <<<"$INPUT"
    assert_output ''
}

@test "fewer output numbers prints error and exits with 5" {
    run -5 mapSelectedLines --select-line-number 1 grep -e b <<<"$INPUT"
    assert_output 'ERROR: The number of output lines (2) does not match the number of input lines (4).'
}

@test "failing command prints error and exits with 5 if it returns fewer lines" {
    run -5 mapSelectedLines --select-line-number 1 sed -e '3q 11' <<<"$INPUT"
    assert_output 'ERROR: The number of output lines (3) does not match the number of input lines (4).'
}

@test "failing command's exit status is returned" {
    run -11 mapSelectedLines --skip-line-number 2 sed -e '$q 11' <<<"$INPUT"
    assert_output - <<'EOF'
foo
baz
quux
EOF
}
