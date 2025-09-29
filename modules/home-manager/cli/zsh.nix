{
  lib,
  config,
  pkgs,
  ...
}:
with lib;
let
  cfg = config.zsh;
in
{
  options.zsh = {
    enable = mkOption {
      type = types.bool;
      default = false;
      description = "Enable zsh shell";
    };
  };
  config = mkIf cfg.enable {
    programs = {
      zsh = {
        enable = true;
        syntaxHighlighting = {
          enable = true;
        };
        history = {
          save = 1000;
          size = 1000;
          expireDuplicatesFirst = true;
          ignoreDups = true;
          ignoreSpace = true;
        };
        shellAliases = {
          ls = "exa";
          l = "exa -lbF --git";
          ll = "exa -lbF --git --icons";
          cat = "bat";
          c = "clear";
          # Integration with direnv
          "tmux" = "direnv exec / tmux";
        };
        sessionVariables = {
          LC_ALL = "en_US.UTF-8";
          MAMBA_ROOT_PREFIX = "$HOME/.micromamba"; # For micromamba
        };
        initContent = ''
            # Disable underline
            # See https://github.com/zsh-users/zsh-syntax-highlighting/issues/573
            (( ''${+ZSH_HIGHLIGHT_STYLES} )) || typeset -A ZSH_HIGHLIGHT_STYLES
            ZSH_HIGHLIGHT_STYLES[path]=none
            ZSH_HIGHLIGHT_STYLES[path_prefix]=none
            ZSH_HIGHLIGHT_STYLES[precommand]=none

            # Function to grep through all commits
            function git-grep-all() {
              git grep "$1" $(git rev-list --all)
          }
            # Hook micromamba
            eval "$(${pkgs.micromamba}/bin/micromamba shell hook --shell zsh)"
        '';
        oh-my-zsh = {
          enable = true;
          plugins = [
            "direnv"
            "git"
            # "git-auto-fetch"
            "fzf"
            "toolbox"
            "z"
            "podman"
            "tmux"
          ];
        };
      };
    };
  };
}
