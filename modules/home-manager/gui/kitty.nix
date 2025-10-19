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
      };
    };
  };
}
