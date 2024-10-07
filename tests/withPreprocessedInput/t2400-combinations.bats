#!/usr/bin/env bats

load fixture

@test "preprocessed lines are passed as arguments with markers {N}" {
    runWithInput $'foo\nbar\nquux\nEOF' withPreprocessedInput --preprocess-command 'sed -ne 2,3p' --command 'printf "got: [%s]\\n" {-1} {1}; sed -e "s/^/{2}> /" {F} - {F}; printf "with: [%s]\\n" {*} {@}'
    [ $status -eq 0 ]
    [ "$output" = "got: [quux]
got: [bar]
quux> bar
quux> quux
quux> foo
quux> bar
quux> quux
quux> EOF
quux> bar
quux> quux
with: [bar
quux]
with: [bar]
with: [quux]" ]
}
