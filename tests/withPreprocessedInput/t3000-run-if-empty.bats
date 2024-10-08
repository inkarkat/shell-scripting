#!/usr/bin/env bats

load fixture
load marker

@test "exits with 1 when no preprocessed output and does not run the command" {
    runWithInput $'foo\nbar\nquux\nEOF' withPreprocessedInput --preprocess-command 'cat >/dev/null' --command "$TO_MARKER_COMMANDLINE"
    [ $status -eq 1 ]
    [ "$output" = "" ]
    assert_no_marker
}

@test "runs the command on --run-if-empty when no preprocessed output" {
    runWithInput $'foo\nbar\nquux\nEOF' withPreprocessedInput --run-if-empty --preprocess-command 'cat >/dev/null' -- sed -e 's/^/> /'
    [ $status -eq 0 ]
    [ "$output" = "> foo
> bar
> quux
> EOF" ]
}

@test "empty preprocessed output is no-op prepended" {
    runWithInput $'foo\nbar\nquux\nEOF' withPreprocessedInput --run-if-empty --preprocess-command 'cat >/dev/null' -- sed -e 's/^/> /'
    [ $status -eq 0 ]
    [ "$output" = "> foo
> bar
> quux
> EOF" ]
}

@test "empty preprocessed output is passed as empty file" {
    runWithInput $'foo\nbar\nquux\nEOF' withPreprocessedInput --run-if-empty --preprocess-command 'cat >/dev/null' -- sed -e 's/^/> /' - '{F}'
    [ $status -eq 0 ]
    [ "$output" = "> foo
> bar
> quux
> EOF" ]
}

@test "empty preprocessed output is passed as one empty argument with marker {*}" {
    runWithInput $'foo\nbar\nquux\nEOF' withPreprocessedInput --run-if-empty --preprocess-command 'cat >/dev/null' --command 'sed -e "s/^/> /"; args=({*}); printf "with: %d\\n" "${#args[@]}"'
    [ $status -eq 0 ]
    [ "$output" = "> foo
> bar
> quux
> EOF
with: 1" ]
}

@test "empty preprocessed output is passed as no arguments with marker {@}" {
    runWithInput $'foo\nbar\nquux\nEOF' withPreprocessedInput --run-if-empty --preprocess-command 'cat >/dev/null' --command 'sed -e "s/^/> /"; args=({@}); printf "with: %d\\n" "${#args[@]}"'
    [ $status -eq 0 ]
    [ "$output" = "> foo
> bar
> quux
> EOF
with: 0" ]
}
