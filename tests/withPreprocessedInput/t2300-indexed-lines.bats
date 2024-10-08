#!/usr/bin/env bats

load fixture

@test "preprocessed lines are passed as arguments with markers {N}" {
    runWithInput $'foo\nbar\nquux\nEOF' withPreprocessedInput --preprocess-command 'sed -ne 2,3p' --command 'printf "got: [%s]\\n" {2}; sed -e "s/^/> /"; printf "with: [%s]\\n" {1}'
    [ $status -eq 0 ]
    [ "$output" = "got: [quux]
> foo
> bar
> quux
> EOF
with: [bar]" ]
}

@test "preprocessed lines are passed as arguments with markers {-N}" {
    runWithInput $'foo\nbar\nquux\nEOF' withPreprocessedInput --preprocess-command 'sed -ne 2,3p' --command 'printf "got: [%s]\\n" {-1}; sed -e "s/^/> /"; printf "with: [%s]\\n" {-2}'
    [ $status -eq 0 ]
    [ "$output" = "got: [quux]
> foo
> bar
> quux
> EOF
with: [bar]" ]
}

@test "out-of-bounds markers yield empty values" {
    runWithInput $'foo\nbar\nquux\nEOF' withPreprocessedInput --preprocess-command 'sed -ne 2,3p' --command 'printf "got no: [%s]\\n" {0} {3} {99} {-3}; sed -e "s/^/> /"; printf "with: [%s]\\n" {1}'
    [ $status -eq 0 ]
    [ "$output" = "got no: []
got no: []
got no: []
got no: []
> foo
> bar
> quux
> EOF
with: [bar]" ]
}
