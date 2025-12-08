#!/usr/bin/env bats

load fixture

@test "command that selectively chooses some appended arguments" {
    run -0 commandWithInput --stdin --command "sh -c 'printf %s\\\\n \$1 \$3' sh"
    assert_output - <<'EOF'
1
4
EOF
}

@test "command that selectively chooses some inserted arguments" {
    run -0 commandWithInput --stdin --command 'argsToLines {} | grep oo'
    assert_output - <<'EOF'
1
4
EOF
}
