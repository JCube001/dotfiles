# shellcheck shell=bash
#
# ~/.bashrc: Sourced by bash(1) for interactive shells.
#

# Return if this script was sourced from a non-interactive shell.
# Always do this check in case someone sources ~/.bashrc manually.
if [[ $- != *i* ]]; then
    return
fi

# Don't put duplicate lines or lines starting with space in the history.
HISTCONTROL=ignoreboth

# Set the maximum number of lines contained in the history file and the
# maximum number of commands to remember in the history list.
HISTFILESIZE=2000
HISTSIZE=1000

# Append to the history file, don't overwrite it.
shopt -s histappend

# Check the window size after each external command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# Help less(1) to display compressed and non-text file types.
if which lesspipe &> /dev/null; then
    eval "$(lesspipe)"
fi

# Enable color support in ls(1) and other tools.
if which dircolors &> /dev/null; then
    if [[ -f "$HOME/.dircolors" ]]; then
        eval "$(dircolors -b "$HOME/.dircolors")"
    else
        eval "$(dircolors -b)"
    fi

    alias ls='ls --color=auto'
    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

# Load alias definitions.
if [[ -f "$HOME/.aliases" ]]; then
    source "$HOME/.aliases"
fi

# Enable programmable completion features.
if ! shopt -oq posix; then
    if [[ -f /usr/share/bash-completion/bash_completion ]]; then
        source /usr/share/bash-completion/bash_completion
    elif [[ -f /etc/bash_completion ]]; then
        source /etc/bash_completion
    fi
fi

# Ensure __git_ps1 is an available function.
if ! type -t __git_ps1 &> /dev/null; then
    if [[ -r /usr/lib/git-core/git-sh-prompt ]]; then
        source /usr/lib/git-core/git-sh-prompt
    elif [[ -r /etc/bash_completion.d/git-prompt ]]; then
        source /etc/bash_completion.d/git-prompt
    else
        __git_ps1() { return; }
    fi
fi

# Set options for the Git PS1 prompt.
GIT_PS1_SHOWDIRTYSTATE=1
GIT_PS1_SHOWSTASHSTATE=1

# On Debian-based systems, set a variable identifying the active chroot.
if [[ ! -v debian_chroot && -r /etc/debian_chroot ]]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# Set the PS1 prompt. Use color and display Git status if possible.
if which tput &> /dev/null && [[ $(tput colors) -ge 8 ]]; then
    PS1='${debian_chroot:+($debian_chroot) }\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[00;36m\]\w\[\033[00m\] [$?]$(__git_ps1 " (%s)")\$ '
else
    PS1='${debian_chroot:+($debian_chroot) }\u@\h:\w [$?]$(__git_ps1 " (%s)")\$ '
fi

# Setup gpg-agent.
GPG_TTY="$(tty)"
export GPG_TTY

# Setup pyenv.
if [[ -d "$HOME/.pyenv" ]]; then
    PYENV_ROOT="$HOME/.pyenv"
    PATH="$PYENV_ROOT/bin:$PATH"
    export PYENV_ROOT PATH
    eval "$(pyenv init -)"
fi
