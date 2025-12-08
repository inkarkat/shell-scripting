#!/usr/bin/env bats

load fixture
load marker

@test "exits with 1 when no preprocessed output and does not run the command" {
    run -1 withPreprocessedInput --preprocess-command 'cat >/dev/null' --command "$TO_MARKER_COMMANDLINE" <<'END'
foo
bar
quux
EOF
END
    assert_output ''
    assert_no_marker
}

@test "runs the command on --run-if-empty when no preprocessed output" {
    run -0 withPreprocessedInput --run-if-empty --preprocess-command 'cat >/dev/null' -- sed -e 's/^/> /' <<'END'
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
EOF
}

@test "empty preprocessed output is no-op prepended" {
    run -0 withPreprocessedInput --run-if-empty --preprocess-command 'cat >/dev/null' -- sed -e 's/^/> /' <<'END'
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
EOF
}

@test "empty preprocessed output is passed as empty file" {
    run -0 withPreprocessedInput --run-if-empty --preprocess-command 'cat >/dev/null' -- sed -e 's/^/> /' - '{F}' <<'END'
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
EOF
}

@test "empty preprocessed output is passed as one empty argument with marker {*}" {
    run -0 withPreprocessedInput --run-if-empty --preprocess-command 'cat >/dev/null' --command 'sed -e "s/^/> /"; args=({*}); printf "with: %d\\n" "${#args[@]}"' <<'END'
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
with: 1
EOF
}

@test "empty preprocessed output is passed as no arguments with marker {@}" {
    run -0 withPreprocessedInput --run-if-empty --preprocess-command 'cat >/dev/null' --command 'sed -e "s/^/> /"; args=({@}); printf "with: %d\\n" "${#args[@]}"' <<'END'
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
with: 0
EOF
}
