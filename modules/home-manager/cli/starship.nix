{
  # https://starship.rs/
  programs.starship = {
    enable = true;
    enableZshIntegration = true;
    enableBashIntegration = true;
    settings = {
      add_newline = false;
      format = "$username$directory$git_branch$git_state$git_status";
      right_format = "$cmd_duration";
      username = {
        disabled = false;
        show_always = true;
        style_user = "green bold";
      };
      character = {
        success_symbol = "[↳](bold green)";
        error_symbol = "[✗](bold red)";
      };
      directory = {
        read_only = "🔒";
        truncate_to_repo = false;
      };
      palettes = {
        catppuccin_frappe = {
          rosewater = "#f2d5cf";
          flamingo = "#eebebe";
          pink = "#f4b8e4";
          mauve = "#ca9ee6";
          red = "#e78284";
          maroon = "#ea999c";
          peach = "#ef9f76";
          yellow = "#e5c890";
          green = "#a6d189";
          teal = "#81c8be";
          sky = "#99d1db";
          sapphire = "#85c1dc";
          blue = "#8caaee";
          lavender = "#babbf1";
          text = "#c6d0f5";
          subtext1 = "#b5bfe2";
          subtext0 = "#a5adce";
          overlay2 = "#949cbb";
          overlay1 = "#838ba7";
          overlay0 = "#737994";
          surface2 = "#626880";
          surface1 = "#51576d";
          surface0 = "#414559";
          base = "#303446";
          mantle = "#292c3c";
          crust = "#232634";
        };
      };
      palette = "catppuccin_frappe";
    };
  };
}
