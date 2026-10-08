#!/bin/bash

bats_require_minimum_version 1.5.0
bats_load_library bats-support
bats_load_library bats-assert

typeset -gra UPPERCASE_COMMAND=(tr '[:lower:]' '[:upper:]')
readonly INPUT=$'foo\nbar\nbaz\nquux'
