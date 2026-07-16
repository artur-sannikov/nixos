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
              background_opacity = 0.75;
              capsule_fill = "hover";
              capsule_opacity = 0.75;
              capsule_thickness = 0.7;
              font_weight = 600;
              radius = 68;
              radius_bottom_right = 16;
              scale = 1.2;
              thickness = 35;
              widget_spacing = 8;
              start = [
                "ram"
                "cpu"
                "battery"
              ];
              center = [
                "clock"
                "media"
              ];
              end = [
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
            # For reference colors see https://catppuccin.com/palette/
            cpu = {
              capsule = true;
              capsule_fill = "#B7BDF8";
              color = "#24273A";
            };
            ram = {
              capsule = true;
              capsule_fill = "#8AADF4";
              color = "#24273A";
            };
            clock = {
              format = "  %A, %e %B %H:%M";
            };
            media = {
              hide_when_no_media = true;
            };

            battery = {
              capsule = true;
              capsule_fill = "#A6DA95";
              color = "#24273A";
              hide_when_full = true;
              hide_when_plugged = false;
            };
            bluetooth = {
              capsule = true;
              capsule_fill = "#8AADF4";
              color = "#24273A";
            };
            brightness = {
              capsule = true;
              capsule_fill = "#EED49F";
              color = "#24273A";
            };
            keyboard_layout = {
              capsule = true;
              capsule_fill = "#B7BDF8";
              color = "#24273A";
            };
            network = {
              capsule = true;
              capsule_fill = "#8BD5CA";
              capsule_radius = "auto";
              color = "#24273A";
              show_label = false;
            };
            nightlight = {
              capsule_fill = "#91D7E3";
            };
            notifications = {
              capsule_fill = "#EE99A0";
              hide_when_no_unread = true;
            };
            session = {
              color = "#CAD3F5";
              icon_color = "#CAD3F5";
            };
            volume = {
              capsule = true;
              capsule_fill = "#74C7EC";
              color = "#1E1E2E";
            };
          };
          nightlight = {
            enabled = true;
            temperature_night = 4500;
          };
          location = {
            sunrise = "07:30";
            sunset = "21:00";
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
            show_instance_count = false;
          };
        };
      };
    };
  };
}
