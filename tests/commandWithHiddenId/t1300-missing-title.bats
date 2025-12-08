#!/usr/bin/env bats

load fixture

@test "a missing TITLE is defaulted to its ID" {
    run -0 commandWithHiddenId --piped --command 'grep oo\\\|00' -- '100' "${INPUT[@]}" '1001'
    assert_output - <<'EOF'
100
1
4
1001
EOF
}
