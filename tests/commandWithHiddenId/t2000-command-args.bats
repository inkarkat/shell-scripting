#!/usr/bin/env bats

load fixture

@test "command that selectively chooses some appended arguments" {
    run commandWithInput --stdin --command "sh -c 'printf %s\\\\n \$1 \$3' sh"
    [ $status -eq 0 ]
    [ "$output" = "1
4" ]
}

@test "command that selectively chooses some inserted arguments" {
    run commandWithInput --stdin --command 'argsToLines {} | grep oo'
    [ $status -eq 0 ]
    [ "$output" = "1
4" ]
}
