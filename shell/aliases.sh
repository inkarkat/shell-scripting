eval "$(runWithPrompt --addAliasSupport augmentLines \
    '12pr' \
    'stdout|stderr|prepend|run-if-empty' \
    '' \
    'between-command|progress'
)"

addAliasSupport commandline \
    'p' \
    'piped|and|or'

addAliasSupport inputToArg \
    'r' \
    'run-if-empty'

eval "$(runWithPrompt --addAliasSupport linesToArg \
    '' \
    '' \
    '' \
    'between-command|progress'
)"
addAliasSupport linesToArgs \
    'r' \
    'run-if-empty'

addAliasSupport placeholderArgument
addAliasSupport placeholderArguments \
    'r' \
    'no-run-if-empty' \
    'n' \
    'command-arguments'

addAliasSupport succeedsOrRetryArg \
    '' \
    'first-failure|either-failure' \
    'r' \
    'retry-command|retry-exec'
addAliasSupport withConcatenatedInput \
    '' \
    'truncate-on-failure|truncate-on-success' \
    'iX' \
    'basedir|base-type|id|truncate-on'
addAliasSupport ytee \
    'iors' \
    'input-buffered|output-buffered|reverse|sequential'
