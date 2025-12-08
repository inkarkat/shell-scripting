#!/usr/bin/env bats

load fixture

@test "a command can select the same entry multiple times" {
    run -0 commandWithHiddenId --piped --command 'echo -e bar\\nquux\\nbar\\nfoo\\nbar' -- "${INPUT[@]}"
    assert_output - <<'EOF'
2
9
2
1
2
EOF
}
