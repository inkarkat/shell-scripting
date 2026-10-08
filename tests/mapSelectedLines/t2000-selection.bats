#!/usr/bin/env bats

load fixture

@test "select a single line number" {
    run -0 mapSelectedLines --select-line-number 2 "${UPPERCASE_COMMAND[@]}" <<<"$INPUT"
    assert_output 'BAR'
}

@test "select multiple line numbers" {
    run -0 mapSelectedLines --select-line-number 3 --select-line-number 1 "${UPPERCASE_COMMAND[@]}" <<<"$INPUT"
    assert_output - <<'EOF'
FOO
BAZ
EOF
}

@test "select multiple line numbers, one exceeding input" {
    run -0 mapSelectedLines --select-line-number 3 --select-line-number 22 --select-line-number 1 "${UPPERCASE_COMMAND[@]}" <<<"$INPUT"
    assert_output - <<'EOF'
FOO
BAZ
EOF
}

@test "select a single line by content" {
    run -0 mapSelectedLines --select-line bar "${UPPERCASE_COMMAND[@]}" <<<"$INPUT"
    assert_output 'BAR'
}

@test "select empty lines" {
    run -0 mapSelectedLines --select-line '' sed -e 's/^$/---/' <<'EOF'

foo

bar

EOF
    assert_output - <<'EOF'
---
---
---
EOF
}

@test "select multiple lines by content" {
    run -0 mapSelectedLines --select-line baz --select-line foo "${UPPERCASE_COMMAND[@]}" <<<"$INPUT"
    assert_output - <<'EOF'
FOO
BAZ
EOF
}

@test "select multiple lines by content, one not present" {
    run -0 mapSelectedLines --select-line baz --select-line doesNotExist --select-line foo "${UPPERCASE_COMMAND[@]}" <<<"$INPUT"
    assert_output - <<'EOF'
FOO
BAZ
EOF
}

@test "select a single line by match" {
    run -0 mapSelectedLines --select-match 'b[aeiou]r' "${UPPERCASE_COMMAND[@]}" <<<"$INPUT"
    assert_output 'BAR'
}

@test "select multiple lines by match" {
    run -0 mapSelectedLines --select-match '^ba' "${UPPERCASE_COMMAND[@]}" <<<"$INPUT"
    assert_output - <<'EOF'
BAR
BAZ
EOF
}

@test "select multiple lines by matches, one not matching" {
    run -0 mapSelectedLines --select-match '^ba' --select-match 'does.*Not.*Exist' --select-match '^.{4}$' "${UPPERCASE_COMMAND[@]}" <<<"$INPUT"
    assert_output - <<'EOF'
BAR
BAZ
QUUX
EOF
}
