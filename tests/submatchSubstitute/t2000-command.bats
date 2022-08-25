#!/usr/bin/env bats

@test "everything" {
    run submatchSubstitute '/here\&there\\: in "&-&", the \1 is \2 for \3; &.' "the whole text" FOO "/BAR\\" $'with\nnew\n\nline'
    [ $status -eq 0 ]
    [ "$output" = '/here&there\: in "the whole text-the whole text", the FOO is /BAR\ for with
new

line; the whole text.' ]
}
