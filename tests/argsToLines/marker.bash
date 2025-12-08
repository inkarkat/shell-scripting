#!/bin/bash

load fixture

setup()
{
    export MARKER="${BATS_TMPDIR}/marker"
    rm -f -- "$MARKER"
}
assert_no_marker()
{
    [ ! -e "$MARKER" ]
}
assert_marker_contents()
{
    local markerContents="$(< "$MARKER")"
    [ "$markerContents" = "${1?}" ]
}
export TO_MARKER_COMMANDLINE='cat >> "$MARKER"'
