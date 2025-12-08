#!/usr/bin/env bats

load fixture
load marker

@test "command's exit status is returned" {
    run -42 withPreprocessedInput --preprocess-command 'sed -ne 2,3p' -- sed -e 's/^/> /' -e '/foo/q 42' <<'END'
foo
bar
quux
EOF
END
    assert_output - <<'EOF'
> bar
> quux
> foo
EOF
}

@test "preprocess-command's exit status is returned and does not run the command" {
    run -11 withPreprocessedInput --preprocess-command 'sed -e "3q 11"' --command "$TO_MARKER_COMMANDLINE" <<'END'
foo
bar
quux
EOF
END
    assert_output ''
    assert_no_marker
}

@test "preprocess-command's exit status is returned and does not run the command with parallel preprocessing" {
    run -11 withPreprocessedInput --parallel-preprocess --preprocess-command 'sed -e "3q 11"' --command "$TO_MARKER_COMMANDLINE" <<'END'
foo
bar
quux
EOF
END
    assert_output ''
    assert_no_marker
}
