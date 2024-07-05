# shellcheck shell=bash
#
# ~/.bash_profile: Sourced by bash(1) for login shells.
# Since this file exists, neither ~/.bash_login nor ~/.profile will be
# sourced by bash(1).
#

# Source ~/.profile since bash(1) only sources this file instead.
if [[ -r "$HOME/.profile" ]]; then
    source "$HOME/.profile"
fi

# Source ~/.bashrc in case this is a login + interactive shell.
if [[ $- == *i* && -r "$HOME/.bashrc" ]]; then
    source "$HOME/.bashrc"
fi
