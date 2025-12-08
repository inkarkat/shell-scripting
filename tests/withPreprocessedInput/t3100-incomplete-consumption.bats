#!/usr/bin/env bats

load fixture
load marker

largeInput()
{
    seq 1 100000
}

@test "still runs the command when the preprocessor does not consume any input" {
    run -0 withPreprocessedInput --run-if-empty --preprocess-command ':' -- sed -e 's/^/> /' <<'END'
foo
bar
quux
EOF
END
    assert_output -e '^(cat: write error: Broken pipe
)?> foo
> bar
> quux
> EOF'
}

@test "still runs the command when the preprocessor does not consume all input" {
    run -0 withPreprocessedInput --preprocess-command 'head -n 3' -- sed -e 's/^/> /' < <(largeInput)
    assert_output -e '^(cat: write error: Broken pipe
)?> 1
> 2
> 3
> 1
> 2
> 3
> 4
> 5'
    assert_output -e '> 99999
> 100000$'
}

@test "exits with 1 or SIGPIPE when parallel preprocessing is enabled and the preprocessor does not consume any input and does not run the command" {
    run withPreprocessedInput --parallel-preprocess --preprocess-command ':' --command "$TO_MARKER_COMMANDLINE" <<'END'
foo
bar
quux
EOF
END
    assert_failure 1 || assert_failure 141
    assert_output ''
    assert_no_marker
}

@test "succeeds or exits with SIGPIPE when parallel preprocessing is enabled and the preprocessor does not consume all input and does not run the command" {
    run withPreprocessedInput --parallel-preprocess --preprocess-command 'head -n 3' --command "$TO_MARKER_COMMANDLINE" < <(largeInput)
    assert_success || { assert_failure 141 && assert_no_marker; }
    assert_output ''
}
