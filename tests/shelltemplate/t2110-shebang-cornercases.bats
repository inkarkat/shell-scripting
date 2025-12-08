#!/usr/bin/env bats

load fixture

@test "different shebang is kept" {
    run -0 shelltemplate "${BATS_TEST_DIRNAME}/different-shebang"
    assert_output - <<EOF
#!/bin/bash
$expected
EOF
}

@test "second, different shebang is kept" {
    run -0 "${BATS_TEST_DIRNAME}/two-shebangs"
    assert_output - <<EOF
#!/bin/bash
$expected
EOF
}

@test "empty second line after shebang is deleted" {
    run -0 "${BATS_TEST_DIRNAME}/shebang-empty-line"
    assert_output "$expected"
}
