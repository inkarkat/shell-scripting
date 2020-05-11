#!/usr/bin/env bats

load fixture

@test "two commands selectively choose some inserted arguments" {
    run commandWithInput --stdin \
	--command "sh -c 'printf %s\\\\n \$1 \$3' sh {}" \
	--command "sh -c 'printf %s\\\\n \$2' sh {}"
    [ $status -eq 0 ]
    [ "$output" = "1
4
2" ]
}

@test "two piped commands reduce the selected candidates" {
    run commandWithInput --stdin --piped \
	--command 'grep b' \
	--command 'grep oo'
    [ $status -eq 0 ]
    [ "$output" = "4" ]
}

@test "two commands, the first is piped into, the second adds a title" {
    run commandWithInput --stdin \
	--command 'grep oo' \
	--command 'echo bar' \
	--piped
    [ $status -eq 0 ]
    [ "$output" = "1
4
2" ]
}
