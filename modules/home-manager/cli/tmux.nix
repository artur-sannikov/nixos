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

        # Split windows
        bind-key v split-window -h -c "#{pane_current_path}"
        bind-key h split-window -v -c "#{pane_current_path}"

        # Switch windows
        bind -n S-Left previous-window
        bind -n S-Right next-window

        # Reorder windows
        bind-key -n C-S-Left swap-window -t -1
        bind-key -n C-S-Right swap-window -t +1

        # Enable copy-to-clipboard on Wayland
        set -s copy-command 'wl-copy'

        # Status bar customization
        set -g status-justify centre
        set -g status-left "";
        set -g status-right '#[fg=#D9E0EE]%H:%M %d/%m/%y'
      '';
    };
  };
}
