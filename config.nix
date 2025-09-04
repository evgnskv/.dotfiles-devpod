{
  packageOverrides = pkgs: with pkgs; {
    myPackages = pkgs.buildEnv {
      name = "toolbox";
      paths = [
        coreutils
        bash-completion
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
