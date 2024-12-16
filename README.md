# Shell Scripting

_A collection of shell scripts that simplify scripting tasks around argument handling, variable interpolation, etc._

![Build Status](https://github.com/inkarkat/shell-scripting/actions/workflows/build.yml/badge.svg)

### Dependencies

* Bash, GNU `sed`
* [inkarkat/shell-basics](https://github.com/inkarkat/shell-basics) for the `commandWithHiddenId` and `commandOnSelected` commands
* [inkarkat/shell-filters](https://github.com/inkarkat/shell-filters) for the `commandWithHiddenId` command
* automated testing is done with _bats - Bash Automated Testing System_ (https://github.com/bats-core/bats-core)

### Installation

* The `./bin` subdirectory is supposed to be added to `PATH`.
* The [shell/aliases.sh](shell/aliases.sh) script (meant to be sourced in `.bashrc`) defines Bash aliases around the provided commands.
* The [shell/completions.sh](shell/completions.sh) script (meant to be sourced in `.bashrc`) defines Bash completions for the provided commands.
* The [profile/exports.sh](profile/exports.sh) sets up configuration; it only needs to be sourced once, e.g. from your `.profile`.
