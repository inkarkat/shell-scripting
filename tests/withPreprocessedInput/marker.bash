#!/bin/bash

markerSetup()
{
    export MARKER="${BATS_TMPDIR}/marker"
    rm -f -- "$MARKER"
}
setup()
{
    markerSetup
}

assert_no_marker()
{
    [ ! -e "$MARKER" ]
}
export TO_MARKER_COMMANDLINE='cat >> "$MARKER"'
