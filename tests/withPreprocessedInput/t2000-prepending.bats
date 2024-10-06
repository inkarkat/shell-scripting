#!/usr/bin/env bats

load fixture

@test "without markers, the preprocessed output is prepended" {
    runWithInput $'foo\nbar\nquux\nEOF' withPreprocessedInput --preprocess-command 'sed -ne 2,3p' -- sed -e 's/^/> /'
    [ $status -eq 0 ]
    [ "$output" = "> bar
> quux
> foo
> bar
> quux
> EOF" ]
}
