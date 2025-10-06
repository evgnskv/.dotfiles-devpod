{
  packageOverrides = pkgs: with pkgs; {
    myPackages = pkgs.buildEnv {
      name = "toolbox";
      paths = [
        coreutils
        bash-completion
        xpra
        bootdev-cli
        go
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
