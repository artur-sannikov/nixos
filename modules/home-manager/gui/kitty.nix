{ lib, ... }:
# mkForce is required because default settings conflict with custom
# definitions
{
  programs = {
    kitty = {
      enable = true;
      font = {
        name = lib.mkForce "Iosevka Term Extended";
        size = lib.mkForce 12;
      };
      shellIntegration = {
        enableBashIntegration = true;
        enableZshIntegration = true;
      };
      settings = {
        scrollback_lines = 10000;
        # Hide mouse pointer when typing
        mouse_hide_wait = "-3.0";
        enable_audio_bell = "no";
        cursor_shape = "beam";
        cursor_beam_thickness = 1.5;
        cursor_blink_interval = 0;
        shell = "zsh";
        copy_on_select = "yes";
      };
      keybindings = {
        "ctrl+f>c" = "new_tab";
        "ctrl+h" = "neighboring_window left";
        "ctrl+l" = "neighboring_window right";
        "ctrl+k" = "neighboring_window up";
        "ctrl+j" = "neighboring_window down";

        "ctrl+f>h" = "move_window left";
        "ctrl+f>l" = "move_window right";
        "ctrl+f>k" = "move_window up";
        "ctrl+f>j" = "move_window down";

        "ctrl+f>," = "set_tab_title";
        "ctrl+f>n" = "next_tab";
        "ctrl+f>p" = "previous_tab";

        "ctrl+f>-" = "launch --location=hsplit";
        "ctrl+'" = "next_layout";
      };
    };
  };
}
