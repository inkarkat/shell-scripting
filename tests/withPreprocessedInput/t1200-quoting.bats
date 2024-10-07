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
