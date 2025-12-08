#!/usr/bin/env bats

load fixture

@test "commandlines with spaces and backslashes are properly quoted" {
    run -0 withPreprocessedInput --preprocess-command "sed -e 's/^/\\\\ with /'" --command "sed -e 'i\\
see'" <<<'foo'
    assert_success
    assert_output - <<'EOF'
see
\ with foo
see
foo
EOF
}

@test "exec commands with spaces and backslashes are properly quoted" {
    run -0 withPreprocessedInput --preprocess-exec  sed -e 's/^/\\ with /' \; --exec sed -e 'i\
see' \; <<<'foo'
    assert_success
    assert_output - <<'EOF'
see
\ with foo
see
foo
EOF
}

@test "commandlines with empty argument are properly quoted" {
    run -0 withPreprocessedInput --preprocess-command "cat >/dev/null; echo one '' three" --command "cat; echo ONE '' THREE" <<<'foo'
    assert_output - <<'EOF'
one  three
foo
ONE  THREE
EOF
}

@test "exec commands with empty argument are properly quoted" {
    WITHPREPROCESSEDINPUT_PREPROCESS_COMMAND_JOINER=';' WITHPREPROCESSEDINPUT_COMMAND_JOINER=';' \
	run -0 withPreprocessedInput --preprocess-command 'cat >/dev/null' --preprocess-exec echo one '' three \; --exec cat \; -- echo ONE '' THREE <<<'foo'
    assert_output - <<'EOF'
one  three
foo
ONE  THREE
EOF
}
