{ pkgs, ... }:
{
  programs = {
    alacritty = {
      enable = true;
      settings = {
        terminal = {
          shell = {
            program = "${pkgs.zsh}/bin/zsh";
            args = [
              "-l"
              "-c"
              "tmux attach || tmux"
            ];
          };
        };
        window = {
          startup_mode = "Maximized";
        };
      };
    };
  };
}
