{ pkgs, ... }:
{
  programs = {
    alacritty = {
      enable = true;
      settings = {
        shell = {
          program = "${pkgs.zsh}/bin/zsh";
        };
        window = {
          startup_mode = "Maximized";
        };
      };
    };
  };
}
