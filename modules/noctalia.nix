{ inputs, ... }:
{
  flake.modules.homeManager.noctalia = {
    imports = [
      inputs.noctalia.homeModules.default
    ];
    programs = {
      noctalia = {
        enable = true;
        settings = {
          # For Niri overview blurred wallpaper
          backdrop = {
            enabled = true;
          };
          bar = {
            main = {
              enabled = true;
              position = "top";
              background_opacity = 0.85;
              start = [
                "ram"
                "cpu"
                "battery"
              ];
              end = [
                "media"
                "tray"
                "notifications"
                "volume"
                "bluetooth"
                "brightness"
                "keyboard_layout"
                "network"
                "nightlight"
                "session"
              ];
            };
          };

          nightlight = {
            enabled = true;
            start_time = "20:30";
            stop_time = "07:00";
          };
          dock = {
            enabled = false;
          };
        };
      };
    };
  };
}
