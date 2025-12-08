#!/usr/bin/env bats

load fixture

setup()
{
    fixtureSetup
    rm -rf -- "${BATS_TMPDIR}/new/dishOutSections/"
}

@test "custom non-existing base dir can be passed and uses different counter database then" {
    run -0 dishOutSections --basedir "${BATS_TMPDIR}/new" --seek 5 "${BATS_TEST_DIRNAME}/input.txt"
    assert_output 'fifth section after empty fourth section'

    run -0 dishOutSections "${BATS_TEST_DIRNAME}/input.txt"
    assert_output $'first section\nwith some text'

    run -0 dishOutSections --basedir "${BATS_TMPDIR}/new" "${BATS_TEST_DIRNAME}/input.txt"
    assert_output 'last section'
}

@test "custom base dir can be reused via base-type config" {
    run -0 dishOutSections --basedir "${BATS_TMPDIR}/new" --seek 5 "${BATS_TEST_DIRNAME}/input.txt"
    assert_output 'fifth section after empty fourth section'

    export XDG_CONFIG_HOME="${BATS_TMPDIR}/new"
    run -0 dishOutSections --base-type config "${BATS_TEST_DIRNAME}/input.txt"
    assert_output 'last section'
}
