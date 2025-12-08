#!/usr/bin/env bats

load fixture

@test "input from stdin" {
    run -0 commandWithInput --stdin --piped --command 'grep oo'
    assert_output - <<'EOF'
1
4
EOF
}

@test "input from the command-line" {
    run -0 commandWithHiddenId --piped --command 'grep oo' -- "${INPUT[@]}"
    assert_output - <<'EOF'
1
4
EOF
}

@test "input from a generator" {
    run -0 commandWithHiddenId --generator "echo '$INPUTSTRING'" --piped --command 'grep oo'
    assert_output - <<'EOF'
1
4
EOF
}

@test "input from a generator that embellishes the arguments from the command-line" {
    run -0 commandWithHiddenId --generator "argsToLines -c 'nl -w1'" --piped --command 'grep oo' foo bar boo quux
    assert_output - <<'EOF'
1
3
EOF
}
