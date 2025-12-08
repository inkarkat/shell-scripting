#!/usr/bin/env bats

load fixture

@test "preprocessed lines are passed as arguments with markers {N}" {
    run -0 withPreprocessedInput --preprocess-command 'sed -ne 2,3p' --command 'printf "got: [%s]\\n" {2}; sed -e "s/^/> /"; printf "with: [%s]\\n" {1}' <<'END'
foo
bar
quux
EOF
END
    assert_output - <<'EOF'
got: [quux]
> foo
> bar
> quux
> EOF
with: [bar]
EOF
}

@test "preprocessed lines are passed as arguments with markers {-N}" {
    run -0 withPreprocessedInput --preprocess-command 'sed -ne 2,3p' --command 'printf "got: [%s]\\n" {-1}; sed -e "s/^/> /"; printf "with: [%s]\\n" {-2}' <<'END'
foo
bar
quux
EOF
END
    assert_output - <<'EOF'
got: [quux]
> foo
> bar
> quux
> EOF
with: [bar]
EOF
}

@test "out-of-bounds markers yield empty values" {
    run -0 withPreprocessedInput --preprocess-command 'sed -ne 2,3p' --command 'printf "got no: [%s]\\n" {0} {3} {99} {-3}; sed -e "s/^/> /"; printf "with: [%s]\\n" {1}' <<'END'
foo
bar
quux
EOF
END
    assert_output - <<'EOF'
got no: []
got no: []
got no: []
got no: []
> foo
> bar
> quux
> EOF
with: [bar]
EOF
}
