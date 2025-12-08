#!/usr/bin/env bats

load fixture

@test "no supplied arguments give no output" {
    run -0 argsToLines
    assert_output ''
}

@test "a single argument is printed" {
    run -0 argsToLines 'foo bar'
    assert_output 'foo bar'
}

@test "multiple arguments are printed on separate lines" {
    run -0 argsToLines 'foo bar' 'quux' 'final'
    assert_output - <<'EOF'
foo bar
quux
final
EOF
}
