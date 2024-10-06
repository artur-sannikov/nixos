{ pkgs, ... }:
{
  programs = {
    tmux = {
      enable = true;
      shell = "${pkgs.zsh}/bin/zsh";
      prefix = "C-f";
      extraConfig = ''
        bind-key r source-file ~/.config/tmux/tmux.conf \; display-message "tmux.conf reloaded."
      '';
    };
  };
}
