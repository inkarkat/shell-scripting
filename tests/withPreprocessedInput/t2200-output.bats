#!/usr/bin/env bats

load fixture

@test "preprocessed output is passed as one argument with marker {*}" {
    run -0 withPreprocessedInput --preprocess-command 'sed -ne 2,3p' --command 'sed -e "s/^/> /"; printf "with: [%s]\\n" {*}' <<'END'
foo
bar
quux
EOF
END
    assert_output - <<'EOF'
> foo
> bar
> quux
> EOF
with: [bar
quux]
EOF
}

@test "preprocessed output is passed as individual arguments with marker {@}" {
    run -0 withPreprocessedInput --preprocess-command 'sed -ne 2,3p' --command 'sed -e "s/^/> /"; printf "with: [%s]\\n" {@}' <<'END'
foo
bar
quux
EOF
END
    assert_output - <<'EOF'
> foo
> bar
> quux
> EOF
with: [bar]
with: [quux]
EOF
}
