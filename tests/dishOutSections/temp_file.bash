#!/bin/bash

bats_load_library bats-file

load fixture

createFile()
{
    cp -f -- "${BATS_TEST_DIRNAME}/input.txt" "${BATS_TMPDIR}/file.txt"
}

setup()
{
    fixtureSetup
    createFile
}
