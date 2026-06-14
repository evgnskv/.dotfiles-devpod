let
  hermes-flake = builtins.getFlake "github:NousResearch/hermes-agent";
  hermes-pkg = hermes-flake.packages.${builtins.currentSystem}.default;
in
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
        fzf
        ripgrep
        lsd
        opencode
        hermes-pkg
        python314Packages.python-telegram-bot
      ];
    };
  };
}
