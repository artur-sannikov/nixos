{ pkgs, ... }:
{
  programs = {
    tmux = {
      enable = true;
      shell = "${pkgs.zsh}/bin/zsh";
      prefix = "C-f";
      extraConfig = ''
        bind-key r source-file ~/.config/tmux/tmux.conf \; display-message "tmux.conf reloaded."

        # Mouse mode
        set -g mouse on

        # Switch panes without prefix key
        bind -n M-Left select-pane -L
        bind -n M-Right select-pane -R
        bind -n M-Up select-pane -U
        bind -n M-Down select-pane -D
      '';
    };
  };
}
