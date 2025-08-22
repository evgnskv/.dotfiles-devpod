#!/bin/bash

export XDG_CONFIG_HOME="$HOME"/.config
export NIXPKGS_ALLOW_UNFREE=1

mkdir -p "$XDG_CONFIG_HOME"
mkdir -p "$XDG_CONFIG_HOME"/nixpkgs

ln -sf "$PWD/nix/.config/nixpkgs/config.nix" \
       "$XDG_CONFIG_HOME"/nixpkgs/config.nix

nix-env -iA nixpkgs.myPackages

stow dotfiles/*
