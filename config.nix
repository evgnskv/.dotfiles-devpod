{
  packageOverrides = pkgs: with pkgs; {
    myPackages = pkgs.buildEnv {
      name = "toolbox";
      paths = [
        coreutils
        bash-completion
        bootdev-cli
        python3
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
