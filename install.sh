#!/bin/bash

export NIXPKGS_ALLOW_UNFREE=1

mkdir -p "$HOME"/.config/nixpkgs
ln -sf "$HOME"/dotfiles/nix/.config/nixpkgs/config.nix \
       "$HOME"/.config/nixpkgs/config.nix

nix-env -iA nixpkgs.myPackages

cd "$HOME"/dotfiles && stow .
