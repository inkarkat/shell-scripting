#!/usr/bin/env bats

load fixture
load marker

@test "command's exit status is returned" {
    runWithInput $'foo\nbar\nquux\nEOF' withPreprocessedInput --preprocess-command 'sed -ne 2,3p' -- sed -e 's/^/> /' -e '/foo/q 42'
    [ $status -eq 42 ]
    [ "$output" = "> bar
> quux
> foo" ]
}

@test "preprocess-command's exit status is returned and does not run the command" {
    runWithInput $'foo\nbar\nquux\nEOF' withPreprocessedInput --preprocess-command 'sed -e "3q 11"' --command "$TO_MARKER_COMMANDLINE"
    [ $status -eq 11 ]
    [ "$output" = "" ]
    assert_no_marker
}

@test "preprocess-command's exit status is returned and does not run the command with parallel preprocessing" {
    runWithInput $'foo\nbar\nquux\nEOF' withPreprocessedInput --parallel-preprocess --preprocess-command 'sed -e "3q 11"' --command "$TO_MARKER_COMMANDLINE"
    [ $status -eq 11 ]
    [ "$output" = "" ]
    assert_no_marker
}
