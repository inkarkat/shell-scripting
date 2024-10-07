#!/usr/bin/env bats

load fixture

@test "example usage" {
    runWithInput $'foo\nbar\nquux\nEOF' withPreprocessedInput --preprocess-command 'wc -l' --exec sed = \; -- sed -e 's#^[0-9]\+$#&/{*}#' -e N -e 's/\n/: /'
    [ $status -eq 0 ]
    [ "$output" = "1/4: foo
2/4: bar
3/4: quux
4/4: EOF" ]

}
