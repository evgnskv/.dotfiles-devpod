{
  packageOverrides = pkgs: with pkgs; {
    myPackages = pkgs.buildEnv {
      name = "toolbox";
      paths = [
        coreutils
        bash-completion
        werf
        go
        atlas
        nodejs_24
        yarn
        ansible
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
