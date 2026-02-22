{
  lib,
  config,
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
          edit = "$EDITOR $(fzf)";
          # See issue here https://sw.kovidgoyal.net/kitty/faq/#i-get-errors-about-the-terminal-being-unknown-or-opening-the-terminal-failing-or-functional-keys-like-arrow-keys-don-t-work
          s = "kitten ssh";

          # Chezmoi re-add dictionary
          # I add new words to ~/.config/harper-ls/dictionary.txt from Neovim
          # so chezmoi cannot detect the changes.
          # One way is to add them directly to the chezmoi repo, but I do
          # not want to mess with it too much
          # It's also possible to run a timer that would re-add it periodically
          chz-harper = "chezmoi re-add ~/.config/harper-ls/dictionary.txt";

        };
        sessionVariables = {
          LC_ALL = "en_US.UTF-8";
          TERM = "xterm-256color";
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
        '';
        oh-my-zsh = {
          enable = true;
          plugins = [
            "ansible"
            "fzf"
            "direnv"
            "git"
            # "git-auto-fetch"
            "toolbox"
            "zoxide"
            "podman"
            "tmux"
          ];
        };
      };
    };
  };
}
