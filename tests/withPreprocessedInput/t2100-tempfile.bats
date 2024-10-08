#!/usr/bin/env bats

load fixture

@test "preprocessed output is passed by temp file with marker {F}" {
    runWithInput $'foo\nbar\nquux\nEOF' withPreprocessedInput --preprocess-command 'sed -ne 2,3p' --command 'sed -e "s/.*/$(head -n 1 {F}) & $(tail -n 1 {F})/"'
    [ $status -eq 0 ]
    [ "$output" = "bar foo quux
bar bar quux
bar quux quux
bar EOF quux" ]
}
