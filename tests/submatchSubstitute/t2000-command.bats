#!/usr/bin/env bats

load fixture

@test "everything" {
    run -0 submatchSubstitute '/here\&there\\: in "&-&", the \1 is \2 for \3; &.' "the whole text" FOO "/BAR\\" $'with\nnew\n\nline'
    assert_output - <<'EOF'
/here&there\: in "the whole text-the whole text", the FOO is /BAR\ for with
new

line; the whole text.
EOF
}
