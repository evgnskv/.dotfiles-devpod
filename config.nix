{
  packageOverrides = pkgs: with pkgs; let
    workspacePackagesFile =
      /workspaces + "/${builtins.getEnv "DEVPOD_WORKSPACE_ID"}/packages.nix";
    workspacePackages =
      if builtins.pathExists workspacePackagesFile
      then import workspacePackagesFile pkgs
      else [ ];
  in {
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
        fzf
        ripgrep
        lsd
        opencode
      ] ++ workspacePackages;
    };
  };
}
