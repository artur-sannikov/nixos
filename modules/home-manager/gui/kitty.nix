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
        mouse_hide_wait = "-3.0";
      };
    };
  };
}
