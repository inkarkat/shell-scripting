#!/usr/bin/env bats

load fixture

@test "print individual fortunes with custom separator" {
    run -0 dishOutSections --section-separator '^--$' "${BATS_TEST_DIRNAME}/fortunes.txt"
    assert_output '@oneliners@'

    run -0 dishOutSections --section-separator '^--$' "${BATS_TEST_DIRNAME}/fortunes.txt"
    assert_output 'A ton of elephant is less than one elephant.'

    run -0 dishOutSections --section-separator '^--$' "${BATS_TEST_DIRNAME}/fortunes.txt"
    assert_output 'The problem of being faster than light is that you can only live in darkness.'

    run -0 dishOutSections --section-separator '^--$' "${BATS_TEST_DIRNAME}/fortunes.txt"
    assert_output "If money doesn't grow on trees, then why have banks branches?"

    run -0 dishOutSections --section-separator '^--$' "${BATS_TEST_DIRNAME}/fortunes.txt"
    assert_output '@twoliners@'
}

@test "print fortune groups with another custom separator" {
    run -0 dishOutSections --section-separator '^@[[:alpha:]]+@$' "${BATS_TEST_DIRNAME}/fortunes.txt"
    assert_output ''

    run -0 dishOutSections --section-separator '^@[[:alpha:]]+@$' "${BATS_TEST_DIRNAME}/fortunes.txt"
    assert_output - <<'EOF'
--
A ton of elephant is less than one elephant.
--
The problem of being faster than light is that you can only live in darkness.
--
If money doesn't grow on trees, then why have banks branches?
--
EOF

    run -0 dishOutSections --section-separator '^@[[:alpha:]]+@$' "${BATS_TEST_DIRNAME}/fortunes.txt"
    assert_output - <<'EOF'
--
My teacher told me years ago not to worry about spelling because in the future
there will be autocorrect. And for that I am eternally grapefruit.
--
There's a fine line between a numerator and a denominator.
Only a fraction of people will find this funny.
--
I don't know how many cookies it takes to be happy,
but so far it's not twenty seven.
EOF
}
