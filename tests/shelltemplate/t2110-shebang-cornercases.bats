#!/usr/bin/env bats

load fixture

@test "different shebang is kept" {
    run shelltemplate --file "${BATS_TEST_DIRNAME}/different-shebang"
    [ $status -eq 0 ]
    [ "$output" = "#!/bin/bash
This is a \"test input\" file on testhost with undefined.
All on $(uname), to be exact $(uname -o)." ]
}
