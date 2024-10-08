#!/usr/bin/env bats

load fixture

@test "preprocessed output is passed as one argument with marker {*}" {
    runWithInput $'foo\nbar\nquux\nEOF' withPreprocessedInput --preprocess-command 'sed -ne 2,3p' --command 'sed -e "s/^/> /"; printf "with: [%s]\\n" {*}'
    [ $status -eq 0 ]
    [ "$output" = "> foo
> bar
> quux
> EOF
with: [bar
quux]" ]
}

@test "preprocessed output is passed as individual arguments with marker {@}" {
    runWithInput $'foo\nbar\nquux\nEOF' withPreprocessedInput --preprocess-command 'sed -ne 2,3p' --command 'sed -e "s/^/> /"; printf "with: [%s]\\n" {@}'
    [ $status -eq 0 ]
    [ "$output" = "> foo
> bar
> quux
> EOF
with: [bar]
with: [quux]" ]
}
