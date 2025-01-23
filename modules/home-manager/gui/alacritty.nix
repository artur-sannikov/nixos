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
        font = {
          normal = {
            family = "IosevkaTerm Nerd Font";
            style = "Regular";
          };
          bold = {
            family = "IosevkaTerm Nerd Font";
            style = "Bold";
          };
          italic = {
            family = "IosevkaTerm Nerd Font";
            style = "Italic";
          };
          bold_italic = {
            family = "IosevkaTerm Nerd Font";
            style = "Bold Italic";
          };
        };
      };
    };
  };
}
