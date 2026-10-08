#!/usr/bin/env bats

load fixture

@test "skipped line number takes precedence over selected line number" {
    run -0 mapSelectedLines --skip-line-number 2 --select-line-number 1 --select-line-number 2 --select-line-number 3 "${UPPERCASE_COMMAND[@]}" <<<"$INPUT"
    assert_output - <<'EOF'
FOO
BAZ
EOF
}

@test "skipped line content takes precedence over selected line content" {
    run -0 mapSelectedLines --select-line foo --select-line bar --select-line baz --skip-line bar "${UPPERCASE_COMMAND[@]}" <<<"$INPUT"
    assert_output - <<'EOF'
FOO
BAZ
EOF
}

@test "skipped match takes precedence over selected match" {
    run -0 mapSelectedLines --skip-match '[xz]$' --select-match '^ba' --select-match 'does.*Not.*Exist' --select-match '^.{4}$' "${UPPERCASE_COMMAND[@]}" <<<"$INPUT"
    assert_output 'BAR'
}
