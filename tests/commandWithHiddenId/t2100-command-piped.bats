#!/usr/bin/env bats

load fixture

@test "command that selectively chooses some piped arguments" {
    run -0 commandWithInput --stdin --piped --command 'grep oo'
    assert_output - <<'EOF'
1
4
EOF
}
