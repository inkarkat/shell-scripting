#!/usr/bin/env bats

load fixture
load marker

largeInputWrapper()
{
    seq 1 100000 | "$@"
}
runWithLargeInput()
{
    run largeInputWrapper "$@"
}

@test "still runs the command when the preprocessor does not consume any input" {
    runWithInput $'foo\nbar\nquux\nEOF' withPreprocessedInput --run-if-empty --preprocess-command ':' -- sed -e 's/^/> /'
    [ $status -eq 0 ]
    [ "$output" = "> foo
> bar
> quux
> EOF" ]
}

@test "still runs the command when the preprocessor does not consume all input" {
    runWithLargeInput withPreprocessedInput --preprocess-command 'head -n 3' -- sed -e 's/^/> /'
    [ $status -eq 0 ]
    [[ "$output" =~ ^"> 1
> 2
> 3
> 1
> 2
> 3
> 4
> 5" ]]
    [[ "$output" =~ "> 99999
> 100000"$ ]]
}

@test "exits with SIGPIPE when parallel preprocessing is enabled and the preprocessor does not consume any input and does not run the command" {
    runWithInput $'foo\nbar\nquux\nEOF' withPreprocessedInput --parallel-preprocess --preprocess-command ':' --command "$TO_MARKER_COMMANDLINE"
    [ $status -eq 141 ]
    [ "$output" = "" ]
    assert_no_marker
}

@test "exits with SIGPIPE when parallel preprocessing is enabled and the preprocessor does not consume all input and does not run the command" {
    runWithLargeInput withPreprocessedInput --parallel-preprocess --preprocess-command 'head -n 3' --command "$TO_MARKER_COMMANDLINE"
    [ $status -eq 141 ]
    [ "$output" = "" ]
    assert_no_marker
}
