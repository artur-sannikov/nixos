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
          widget = {
            clock = {
              format = "  %A, %e %B %H:%M";
            };
            media = {
              hide_when_no_media = true;
            };
          };
          nightlight = {
            enabled = true;
            start_time = "20:30";
            stop_time = "07:00";
          };
          idle = {
            behavior = {
              screen-off = {
                enabled = true;
                timeout = 300;
                action = "screen_off";
              };
              lock = {
                enabled = true;
                timeout = 600;
                action = "lock";
              };
            };
          };
          dock = {
            enabled = false;
          };
        };
      };
    };
  };
}
