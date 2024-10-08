#!/usr/bin/env bats

load fixture

@test "commandlines with spaces and backslashes are properly quoted" {
    runWithInput 'foo' withPreprocessedInput --preprocess-command "sed -e 's/^/\\\\ with /'" --command "sed -e 'i\\
see'"
    [ $status -eq 0 ]
    [ "$output" = 'see
\ with foo
see
foo' ]
}

@test "exec commands with spaces and backslashes are properly quoted" {
    runWithInput 'foo' withPreprocessedInput --preprocess-exec  sed -e 's/^/\\ with /' \; --exec sed -e 'i\
see' \;
    [ $status -eq 0 ]
    [ "$output" = 'see
\ with foo
see
foo' ]
}

@test "commandlines with empty argument are properly quoted" {
    runWithInput 'foo' withPreprocessedInput --preprocess-command "cat >/dev/null; echo one '' three" --command "cat; echo ONE '' THREE"
    [ $status -eq 0 ]
    [ "$output" = 'one  three
foo
ONE  THREE' ]
}

@test "exec commands with empty argument are properly quoted" {
    WITHPREPROCESSEDINPUT_PREPROCESS_COMMAND_JOINER=';' WITHPREPROCESSEDINPUT_COMMAND_JOINER=';' \
	runWithInput 'foo' withPreprocessedInput --preprocess-command 'cat >/dev/null' --preprocess-exec echo one '' three \; --exec cat \; -- echo ONE '' THREE
    [ $status -eq 0 ]
    [ "$output" = 'one  three
foo
ONE  THREE' ]
}
