#!/bin/bash

export NIXPKGS_ALLOW_UNFREE=1

ln -sf "$PWD/nix/.config/nixpkgs/config.nix" \
       "$HOME"/.config/nixpkgs/config.nix

nix-env -iA nixpkgs.myPackages

cd "$HOME"/dotfiles && stow .
