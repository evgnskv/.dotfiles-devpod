#!/bin/bash

export XDG_CONFIG_HOME="$HOME"/.config
export NIXPKGS_ALLOW_UNFREE=1

mkdir -p "$XDG_CONFIG_HOME"/nixpkgs
mkdir -p "$XDG_CONFIG_HOME"/opencode

ln -sf "$PWD"/config.nix \
       "$XDG_CONFIG_HOME"/nixpkgs/config.nix
ln -sf "$PWD"/nvim \
       "$XDG_CONFIG_HOME"/nvim

ln -sf "$PWD"/.bashrc \
       "$HOME"/.bashrc
ln -sf "$PWD"/.bash_aliases \
       "$HOME"/.bash_aliases

ln -sf "$PWD"/.tmux.conf \
       "$HOME"/.tmux.conf

ln -sf "$PWD"/.gitconfig \
       "$HOME"/.gitconfig
ln -sf "$PWD"/.gitignore \
       "$HOME"/.gitignore

ln -sf "$PWD"/opencode.json \
       "$HOME"/opencode/opencode.json

nix-env -iA nixpkgs.myPackages

