#!/usr/bin/env bats

load fixture

@test "without generator and with filter, no passed entries cause error" {
    run -124 commandWithHiddenId --filter 'sed -e /f/d -e s/u/o/g' --piped --command 'grep oo'
    assert_output ''
}

@test "without generator and with filter, passed entries are filtered" {
    run -0 commandWithHiddenId --filter "argsToLines -c 'sed -e /f/d -e s/u/o/g'" --piped --command 'grep oo' -- "${INPUT[@]}"
    assert_output - <<'EOF'
4
9
EOF
}

@test "without generator and with empty filter, passed entries are used directly" {
    run -0 commandWithHiddenId --filter '' --piped --command 'grep oo' -- "${INPUT[@]}"
    assert_output - <<'EOF'
1
4
EOF
}

@test "with generator and with filter, no passed entries use generator" {
    run -0 commandWithHiddenId --generator "echo '$INPUTSTRING'" --filter 'sed -e /f/d -e s/u/o/g' --piped --command 'grep oo'
    assert_output - <<'EOF'
1
4
EOF
}

@test "with generator and with filter, passed entries are filtered" {
    run -0 commandWithHiddenId --generator "echo '$INPUTSTRING'" --filter "argsToLines -c 'sed -e /f/d -e s/u/o/g'" --piped --command 'grep oo' -- "${INPUT[@]/#/5}"
    assert_output - <<'EOF'
54
59
EOF
}

@test "with generator and with empty filter, passed entries are used directly" {
    run -0 commandWithHiddenId --generator "echo '$INPUTSTRING'" --filter '' --piped --command 'grep oo' -- "${INPUT[@]/#/5}"
    assert_output - <<'EOF'
51
54
EOF
}
