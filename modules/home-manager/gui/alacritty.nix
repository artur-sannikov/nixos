{ pkgs, ... }:
{
  programs = {
    alacritty = {
      enable = true;
      settings = {
        env = {
          TERM = "xterm-256color";
        };
        terminal = {
          shell = {
            program = "${pkgs.zsh}/bin/zsh";
          };
        };
        window = {
          startup_mode = "Maximized";
        };
      };
    };
  };
}
