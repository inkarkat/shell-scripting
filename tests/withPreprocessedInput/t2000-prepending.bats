#!/usr/bin/env bats

load fixture

@test "without markers, the preprocessed output is prepended" {
    run -0 withPreprocessedInput --preprocess-command 'sed -ne 2,3p' -- sed -e 's/^/> /' <<'END'
foo
bar
quux
EOF
END
    assert_output - <<'EOF'
> bar
> quux
> foo
> bar
> quux
> EOF
EOF
}
