# Shell Scripting

_A collection of shell scripts that simplify scripting tasks around argument handling, variable interpolation, etc._

### Dependencies

* Bash, GNU `sed`
* [inkarkat/shell-basics](https://github.com/inkarkat/shell-basics) for the `commandWithHiddenId` and `commandOnSelected` commands
* automated testing is done with _bats - Bash Automated Testing System_ (https://github.com/bats-core/bats-core)

### Installation

* The `./bin` subdirectory is supposed to be added to `PATH`.
* The [shell/aliases.sh](shell/aliases.sh) script (meant to be sourced in `.bashrc`) defines Bash aliases around the provided commands.
* The [shell/completions.sh](shell/completions.sh) script (meant to be sourced in `.bashrc`) defines Bash completions for the provided commands.
* The [profile/exports.sh](profile/exports.sh) sets up configuration; it only needs to be sourced once, e.g. from your `.profile`.
