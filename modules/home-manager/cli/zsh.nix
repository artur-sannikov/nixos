{
  programs = {
    zsh = {
      enable = true;
      syntaxHighlighting = {
        enable = true;
      };
      history = {
        path = "$HOME/.histfile";
        save = 10000;
        size = 10000;
        expireDuplicatesFirst = true;
        ignoreDups = true;
        ignoreSpace = true;
      };
      shellAliases = {
        "l." = "ls -ldh .";
        "l" = "ls -lh";
      };
      initExtra = ''
        # Disable underline
        # See https://github.com/zsh-users/zsh-syntax-highlighting/issues/573
        (( ''${+ZSH_HIGHLIGHT_STYLES} )) || typeset -A ZSH_HIGHLIGHT_STYLES
        ZSH_HIGHLIGHT_STYLES[path]=none
        ZSH_HIGHLIGHT_STYLES[path_prefix]=none
        ZSH_HIGHLIGHT_STYLES[precommand]=none
      '';
      oh-my-zsh = {
        enable = true;
        plugins = [
          "git"
          "toolbox"
          "z"
          "podman"
        ];
      };
    };
  };
}
