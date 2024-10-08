#!/usr/bin/env bats

load fixture
load marker

@test "exits with SIGPIPE when the preprocessor does not consume the input and does not run the command" {
    runWithInput $'foo\nbar\nquux\nEOF' withPreprocessedInput --preprocess-command ':' --command "$TO_MARKER_COMMANDLINE"
    [ $status -eq 141 ]
    [ "$output" = "" ]
    assert_no_marker
}
