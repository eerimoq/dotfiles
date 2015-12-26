#!/bin/bash
cd
rm -f .emacs && ln -s dotfiles/.emacs .emacs
rm -f .bashrc && ln -s dotfiles/.bashrc .bashrc
rm -f .bash_profile && ln -s dotfiles/.bash_profile .bash_profile
rm -f .bash_aliases && ln -s dotfiles/.bash_aliases .bash_aliases
rm -f .gitconfig && ln -s dotfiles/.gitconfig .gitconfig
rm -f .gitignore && ln -s dotfiles/.gitignore .gitignore

# emacs c navigation
apt-get install xcscope-el
