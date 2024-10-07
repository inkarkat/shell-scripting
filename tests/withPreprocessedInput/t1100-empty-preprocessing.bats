#!/usr/bin/env bats

load fixture

@test "exits with SIGPIPE when no preprocessed output and does not run the command" {
    runWithInput $'foo\nbar\nquux\nEOF' withPreprocessedInput --preprocess-command ':' -- sed -e 's/^/> /'
    [ $status -eq 141 ]
    [ "$output" = "" ]
}
