#!/usr/bin/env bats

load fixture

@test "command's exit status is returned" {
    runWithInput $'foo\nbar\nquux\nEOF' withPreprocessedInput --preprocess-command 'sed -ne 2,3p' -- sed -e 's/^/> /' -e '/foo/q 42'
    [ $status -eq 42 ]
    [ "$output" = "> bar
> quux
> foo" ]
}
