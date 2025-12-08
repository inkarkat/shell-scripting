#!/usr/bin/env bats

load fixture

@test "-h prints long usage help" {
  run -0 evalFile -h
    refute_line -n 0 -e '^Usage:'
    assert_output -e 'Usage:'
}
