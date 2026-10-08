#!/usr/bin/env bats

load fixture

@test "skip a single line number" {
    run -0 mapSelectedLines --skip-line-number 2 "${UPPERCASE_COMMAND[@]}" <<<"$INPUT"
    assert_output - <<'EOF'
FOO
BAZ
QUUX
EOF
}

@test "skip multiple line numbers" {
    run -0 mapSelectedLines --skip-line-number 3 --skip-line-number 1 "${UPPERCASE_COMMAND[@]}" <<<"$INPUT"
    assert_output - <<'EOF'
BAR
QUUX
EOF
}

@test "skip multiple line numbers, one exceeding input" {
    run -0 mapSelectedLines --skip-line-number 3 --skip-line-number 22 --skip-line-number 1 "${UPPERCASE_COMMAND[@]}" <<<"$INPUT"
    assert_output - <<'EOF'
BAR
QUUX
EOF
}

@test "skip a single line by content" {
    run -0 mapSelectedLines --skip-line bar "${UPPERCASE_COMMAND[@]}" <<<"$INPUT"
    assert_output - <<'EOF'
FOO
BAZ
QUUX
EOF
}

@test "skip empty lines" {
    run -0 mapSelectedLines --skip-line '' sed -e 's/^/X-/' -e 's/^$/---/' <<'EOF'

foo

bar

EOF
    assert_output - <<'EOF'
X-foo
X-bar
EOF
}

@test "skip multiple lines by content" {
    run -0 mapSelectedLines --skip-line baz --skip-line foo "${UPPERCASE_COMMAND[@]}" <<<"$INPUT"
    assert_output - <<'EOF'
BAR
QUUX
EOF
}

@test "skip multiple lines by content, one not present" {
    run -0 mapSelectedLines --skip-line baz --skip-line doesNotExist --skip-line foo "${UPPERCASE_COMMAND[@]}" <<<"$INPUT"
    assert_output - <<'EOF'
BAR
QUUX
EOF
}

@test "skip a single line by match" {
    run -0 mapSelectedLines --skip-match 'b[aeiou]r' "${UPPERCASE_COMMAND[@]}" <<<"$INPUT"
    assert_output - <<'EOF'
FOO
BAZ
QUUX
EOF
}

@test "skip multiple lines by match" {
    run -0 mapSelectedLines --skip-match '^ba' "${UPPERCASE_COMMAND[@]}" <<<"$INPUT"
    assert_output - <<'EOF'
FOO
QUUX
EOF
}

@test "skip multiple lines by matches, one not matching" {
    run -0 mapSelectedLines --skip-match '^ba' --skip-match 'does.*Not.*Exist' --skip-match '^.{4}$' "${UPPERCASE_COMMAND[@]}" <<<"$INPUT"
    assert_output 'FOO'
}
