#!/bin/bash
export XDG_CONFIG_HOME="$HOME"/.config
mkdir -p "$XDG_CONFIG_HOME"
mkdir -p "$XDG_CONFIG_HOME"/nixpkgs

ln -sf "$PWD/config.nix" "$XDG_CONFIG_HOME"/nixpkgs/config.nix

ln -sf "$PWD/.tmux.conf" "$XDG_CONFIG_HOME"/.tmux.conf

nix-env -iA nixpkgs.myPackages
