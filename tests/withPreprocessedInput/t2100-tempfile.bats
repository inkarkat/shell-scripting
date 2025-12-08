#!/usr/bin/env bats

load fixture

@test "preprocessed output is passed by temp file with marker {F}" {
    run -0 withPreprocessedInput --preprocess-command 'sed -ne 2,3p' --command 'sed -e "s/.*/$(head -n 1 {F}) & $(tail -n 1 {F})/"' <<'END'
foo
bar
quux
EOF
END
    assert_output - <<'EOF'
bar foo quux
bar bar quux
bar quux quux
bar EOF quux
EOF
}
