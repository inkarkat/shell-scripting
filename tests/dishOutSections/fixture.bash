#!/bin/bash

bats_require_minimum_version 1.5.0
bats_load_library bats-support
bats_load_library bats-assert

export XDG_DATA_HOME="$BATS_TMPDIR"

fixtureSetup()
{
    rm -rf -- "${BATS_TMPDIR:?}/dishOutSections"
}
setup()
{
    fixtureSetup
}
