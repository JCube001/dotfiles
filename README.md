# My Dotfiles

My personal set of dotfiles. Nothing too fancy, just some shell startup scripts. The usual dotfiles warning applies: I wrote these files for *me*, so be sure to inspect these files before you consider incorporating them in your setup.

## Design Notes

* All text files have LF line endings.
* I'm using a `.profile` file because I run a lot of different build systems, and some of them might try to invoke `/bin/sh` login shells.
* `install.sh` shall back up the original/first version of the files it's replacing as `.orig` files.
* `install.sh` shall deploy files by copying from here to the destination. I'm not using symlinks because I want to be able to test the changes I make in this project prior to deploying them for real.
