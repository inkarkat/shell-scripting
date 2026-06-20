#!/usr/bin/env bats

load fixture

@test "two exec commands selectively choose some inserted arguments" {
    run -0 commandWithInput --stdin \
	--exec sh -c 'printf %s\\n $1 $3' sh {} \; \
	--exec sh -c 'printf %s\\n $2' sh {} \;
    assert_output - <<'EOF'
1
4
2
EOF
}

@test "two piped exec commands reduce the selected candidates" {
    run -0 commandWithInput --stdin --piped \
	--exec grep b \; \
	--exec grep oo \;
    assert_output '4'
}

@test "two exec commands, the first is piped into, the second adds a title" {
    run -0 commandWithInput --stdin \
	--exec grep oo \; \
	--exec echo bar \; \
	--piped
    assert_output - <<'EOF'
1
4
2
EOF
}
