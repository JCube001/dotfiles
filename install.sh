#!/bin/bash
#
# install.sh: Installs these dotfiles.
#

set -o nounset

usage() {
    echo "$0 [options]"
    echo
    echo "    Installs these dotfiles."
    echo
    echo "Options:"
    echo "    -h, --help    Display this information and exit."
    echo
}

install_dotfile() {
    src="$1"
    dest="$HOME/$src"
    orig="$dest.orig"

    if [[ -f $dest && ! -f $orig ]]; then
        cp "$dest" "$orig" || return 1
    fi

    cp "$src" "$dest"
}

# Parse command line options.
temp=$(getopt -o 'h' -l 'help' -- "$@")

case $? in
    0)
        ;;
    1)
        usage
        exit 1
        ;;
    *)
        echo 'internal error'
        exit 1
        ;;
esac

eval set -- "$temp"
unset temp

# Handle each command line option.
while true; do
    case "$1" in
        -h|--help)
            usage
            exit
            ;;
        --)
            shift
            break
            ;;
        *)
            echo 'internal error'
            exit 1
            ;;
    esac
done

# Ensure ~/.local/bin exists so it will always be added to the PATH and
# available for dropping one-off executables into.
mkdir -p "$HOME/.local/bin"

# Install the dotfiles.
dotfiles=(.aliases .bash_profile .bashrc .profile)
for file in "${dotfiles[@]}"; do
    install_dotfile "$file"
done
