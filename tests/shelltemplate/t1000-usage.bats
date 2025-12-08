#!/usr/bin/env bats

load fixture

@test "-h prints long usage help" {
  run -0 shelltemplate -h
    refute_line -n 0 -e '^Usage:'
    assert_line -n -1 -e '^Usage:'
}

@test "3 arguments with --file gives error and usage" {
    run -2 shelltemplate --file input.txt output.txt additional.txt
    assert_line -n -1 -e '^Usage:'
}

@test "3 arguments without --file gives error and usage" {
    run -2 shelltemplate output.txt input.txt additional.txt
    assert_line -n -1 -e '^Usage:'
}

@test "4 arguments with -- gives error and usage" {
    run -2 shelltemplate -- output.txt input.txt additional.txt
    assert_line -n -1 -e '^Usage:'
}

@test "duplicate --file gives error and usage" {
    run -2 shelltemplate --file input.txt --file additional.txt
    assert_line -n -1 -e '^Usage:'
}
