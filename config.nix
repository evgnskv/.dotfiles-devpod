{
  packageOverrides = pkgs: with pkgs; {
    myPackages = pkgs.buildEnv {
      name = "toolbox";
      paths = [
        coreutils
        xorg.libX11
        xorg.xdpyinfo
        bash-completion
        bootdev-cli
        go
        python3
        uv
        jq
        yq
      	tmux
      	neovim
        stow
        sshuttle
        fzf
        ripgrep
        lsd
      ];
    };
  };
}
