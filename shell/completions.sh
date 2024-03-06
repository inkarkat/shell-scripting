#!/bin/sh source-this-script

completeAsCommand argsAnd argsOrError argsToArgs argsToLines augmentLines \
    commandOnSelected commandWithHiddenId \
    inputToArg linesToArg linesToArgs \
    pipelineBuilder placeholderArguments printfWithCommands \
    succeedsOrRetryArg swallowArguments withConcatenatedInput ytee
