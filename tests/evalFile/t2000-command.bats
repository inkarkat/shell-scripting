#!/usr/bin/env bats

load fixture

unset PASSWORD
export WHAT='test input'
export HOST_VAR=testhost

@test "environment variable expansion" {
    run -0 evalFile <<<'${WHAT}${WHAT:+ }file on $HOST_VAR with ${PASSWORD:-undefined}'
    assert_output 'test input file on testhost with undefined'
}

@test "environment variable expansion with quotes" {
    run -0 evalFile <<<"\${WHAT:+\$SQ}\${WHAT}\${WHAT:+\" }file on \$HOST_VAR with \${PASSWORD:-undefined}"
    assert_output "'test input\" file on testhost with undefined"
}

@test "undoubling of backslashes" {
    run -0 evalFile <<<'//mymy\\\\ /single\\ things'
    assert_output '//mymy\\ /single\ things'
}

@test "escaping of dollar sign" {
    run -0 evalFile <<<"This escaping of \\\$\\\$\\\$s for 'here' and \"there\"."
    assert_output "This escaping of \$\$\$s for 'here' and \"there\"."
}

@test "no globbing" {
    run -0 evalFile <<<'Just a * for /home/*'
    assert_output 'Just a * for /home/*'
}

@test "no dollar-single quote string expansion" {
    run -0 evalFile <<<"A literal $'\n' or $'nono'"
    assert_output "A literal $'\n' or $'nono'"
}

@test "command substitution" {
    run -0 evalFile <<<"All on `uname`, to be exact \$(echo -e 'What do\\nI know?')."
    assert_output 'All on Linux, to be exact What do
I know?.'
}

@test "command substitution with quotes" {
    typeset -A data=(
	["\`printf '%s\\n' 'foo bar' 'and more'\`"]=$'foo bar\nand more'
	["\$(printf '%s\\n' 'foo bar' 'and more')"]=$'foo bar\nand more'
	['`printf "%s\\n" "foo bar" "and more"`']=$'foo bar\nand more'
	['$(printf "%s\\n" "foo bar" "and more")']=$'foo bar\nand more'
	["\`printf \"%s\\\\n\" 'foo bar' \"and more\"\`"]=$'foo bar\nand more'
	["\$(printf \"%s\\\\n\" 'foo bar' \"and more\")"]=$'foo bar\nand more'
	["This \"result\" is '\`printf '%s\\n' 'foo bar' 'and more'\`' and \"results\" are \`echo \"many\"\` here."]=$'This "result" is \'foo bar\nand more\' and "results" are many here.'
	["This \"result\" is '\$(printf '%s\\n' 'foo bar' 'and more')' and \"results\" are \`echo \"many\"\` here."]=$'This "result" is \'foo bar\nand more\' and "results" are many here.'
	["\`printf '%s\\n' 'foo bar' 'and more'\`\`echo \" and many \"\`\`echo more\`"]=$'foo bar\nand more and many more'
	["\$(printf '%s\\n' 'foo bar' 'and more')\$(echo \" and many \")\$(echo more)"]=$'foo bar\nand more and many more'
	["\$(printf '%s\\n' 'foo bar' 'and more')\`echo \" and many \"\`\$(echo more)"]=$'foo bar\nand more and many more'
    )
    for value in "${!data[@]}"
    do
	run -0 evalFile <<<"$value" \
	    && assert_output "${data["$value"]}" \
	    || fail "$value should yield ${data["$value"]}"
    done
}

@test "command substitution returning a single quote" {
    for input in \
	"\$(echo -e 'A single quote: \x27')." \
	'$(echo -e "A single quote: \\x27").'
    do
	run -0 evalFile <<<"$input" \
	    && assert_output "A single quote: '." \
	    || fail "$input"
    done
}

@test "command substitution returning a double quote" {
    for input in \
	"\$(echo -e 'A double quote: \x22')." \
	'$(echo -e "A double quote: \\x22").'
    do
	run -0 evalFile <<<"$input" \
	    && assert_output 'A double quote: ".' \
	    || fail "$input"
    done
}

@test "processing of a single input file" {
    run -0 evalFile "${BATS_TEST_DIRNAME}/input.txt"
    assert_output - < "${BATS_TEST_DIRNAME}/expected.txt"
}

@test "processing of a standard input specified as - FILE" {
    run -0 evalFile - < "${BATS_TEST_DIRNAME}/input.txt"
    assert_output - < "${BATS_TEST_DIRNAME}/expected.txt"
}

@test "processing of a standard input when no arguments are given" {
    run -0 evalFile < "${BATS_TEST_DIRNAME}/input.txt"
    assert_output - < "${BATS_TEST_DIRNAME}/expected.txt"
}

@test "processing of a multiple input files" {
    run -0 evalFile <(echo 'using process substitution for $WHAT') <(echo -e '$HOST_VAR\n${HOST_VAR}.')
    assert_output - <<'EOF'
using process substitution for test input
testhost
testhost.
EOF
}
