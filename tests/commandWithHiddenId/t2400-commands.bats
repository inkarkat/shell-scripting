#!/usr/bin/env bats

load fixture

@test "two commands selectively choose some inserted arguments" {
    run -0 commandWithInput --stdin \
	--command "sh -c 'printf %s\\\\n \$1 \$3' sh {}" \
	--command "sh -c 'printf %s\\\\n \$2' sh {}"
    assert_output - <<'EOF'
1
4
2
EOF
}

@test "two piped commands reduce the selected candidates" {
    run -0 commandWithInput --stdin --piped \
	--command 'grep b' \
	--command 'grep oo'
    assert_output '4'
}

@test "two commands, the first is piped into, the second adds a title" {
    run -0 commandWithInput --stdin \
	--command 'grep oo' \
	--command 'echo bar' \
	--piped
    assert_output - <<'EOF'
1
4
2
EOF
}
