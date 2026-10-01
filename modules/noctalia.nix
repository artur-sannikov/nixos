{
  flake.modules.homeManager.noctalia = {
    programs = {
      noctalia = {
        enable = true;
        settings = {
          # For Niri overview blurred wallpaper
          backdrop = {
            enabled = true;
          };
          bar = {
            # See default settings https://docs.noctalia.dev/v5/bar/#_top
            # I force them to be this way
            main = {
              position = "top";
              enabled = true;
              auto_hide = false;
              smart_auto_hide = false;
              show_on_workspace_switch = true;
              reserve_space = true;
              layer = "top";

              thickness = 50;
              background_opacity = 0.75;
              border = "outline";
              border_width = 0.0;
              shadow = true;
              contact_shadow = false;
              panel_overlap = 1;
              radius = 68;
              radius_top_left = 12;
              radius_top_right = 12;
              radius_bottom_left = 12;
              radius_bottom_right = 12;
              concave_edge_corners = true;
              margin_ends = 100;
              margin_edge = 0;
              margin_opposite_edge = 0;
              padding = 14;
              widget_spacing = 8;
              hover_highlight = true;
              scale = 1.35;
              font_weight = 600;
              font_family = "";

              # Default capsule style for all widgets on this bar (see Widget Capsule section)
              capsule = false;
              capsule_fill = "surface_variant";
              capsule_thickness = 0.76; # capsule size across the bar as a fraction of bar thickness (1.0 fills the bar)
              capsule_radius = 8.0; # omit for automatic pill radius
              capsule_opacity = 1.0;

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
          accessibility = {
            ui_scale = 1.35; # content scale for panels and non-bar shell UI
            high_contrast = false; # enable high contrast mode for visually impaired
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
            custom_schedule = true;
            sunrise = "07:30";
            sunset = "21:00";
          };
          brightness = {
            enable_ddcutil = true; # Control brightness with ddcutil
          };
          control_center = {
            hidden_tabs = [
              "weather"
              "screen-time"
            ];
          };
          weather.enabled = false;
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
