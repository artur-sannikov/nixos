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
        tab_title_template = "{fmt.fg.red}{bell_symbol}{activity_symbol}{fmt.fg.tab}{tab.last_focused_progress_percent}{index}:{title}";
        enabled_layouts = "stack,horizontal,vertical,splits,tall:bias=50;full_size=1;mirrored=true";
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

        "ctrl+f>-" = "launch --cwd=current --location=hsplit";
        "ctrl+'" = "next_layout";

        # Move between tabs
        "ctrl+f>1" = "goto_tab 1";
        "ctrl+f>2" = "goto_tab 2";
        "ctrl+f>3" = "goto_tab 3";
        "ctrl+f>4" = "goto_tab 4";
        "ctrl+f>5" = "goto_tab 5";
        "ctrl+f>6" = "goto_tab 6";
        "ctrl+f>7" = "goto_tab 7";
        "ctrl+f>8" = "goto_tab 8";
        "ctrl+f>9" = "goto_tab 9";
      };
    };
  };
}
