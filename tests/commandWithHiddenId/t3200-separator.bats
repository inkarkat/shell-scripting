#!/usr/bin/env bats

load fixture

@test "takes any whitespace as separator by default" {
    run -0 commandWithHiddenId --stdin --piped --command 'grep o' <<'EOF'
1    foo
2	bor
3 	 	boo
4			qoox
9			XXX
EOF
    assert_output - <<'EOF'
1
2
3
4
EOF
}

@test "configured to only take tab as separator" {
    COMMANDWITHHIDDENID_SEPARATOR_GLOB=$'\t' run -0 commandWithHiddenId --stdin --piped --command 'grep o' <<'EOF'
1    foo
2	bor
3 	 	boo
4			qoox
9			XXX
EOF
    assert_output - <<'EOF'
1    foo
2
3 
4
EOF
}

@test "configured to only take : or ; as separator" {
    COMMANDWITHHIDDENID_SEPARATOR_GLOB='[:;]' run -0 commandWithHiddenId --stdin --piped --command 'grep o' <<'EOF'
1    foo
2 for 1:bor
this 3;boo
4:qoox
9-XXX
EOF
    assert_output - <<'EOF'
1    foo
2 for 1
this 3
4
EOF
}
