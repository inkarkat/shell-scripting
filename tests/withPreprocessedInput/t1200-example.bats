#!/usr/bin/env bats

load fixture

@test "example usage" {
    run -0 withPreprocessedInput --preprocess-command 'wc -l' --exec sed = \; -- sed -e 's#^[0-9]\+$#&/{*}#' -e N -e 's/\n/: /' <<'END'
foo
bar
quux
EOF
END
    assert_output - <<'EOF'
1/4: foo
2/4: bar
3/4: quux
4/4: EOF
EOF
}
