{
  flake.modules = {
    nixos.niri = {
      programs = {
        niri = {
          enable = true;
        };
      };
      services = {
        gnome = {
          gnome-keyring = {
            enable = true;
          };
        };
      };
      programs = {
        nm-applet = {
          enable = true;
        };
      };
    };

    homeManager.niri =
      { pkgs, ... }:
      let
        create-screenshot = pkgs.writeShellScript "create-screenshot" ''
          ${pkgs.grim}/bin/grim -g "$(${pkgs.slurp}/bin/slurp -c '#ff0000ff')" - | ${pkgs.satty}/bin/satty --filename - --fullscreen --output-filename ~/Pictures/Screenshots/satty-$(date '+%Y%m%d-%H:%M:%S').png
        '';
      in
      {
        wayland.windowManager = {
          niri = {
            enable = true;
            settings = {
              debug.honor-xdg-activation-with-invalid-serial = { };

              prefer-no-csd = true;

              input = {
                touchpad = {
                  tap = { };
                  dwt = { }; # Disable while typing
                  natural-scroll = { };
                };
                keyboard.xkb.layout = "us,ru,fi";
              };

              layout = {
                gaps = 5;

                preset-column-widths._children = [
                  { proportion = 1.0 / 3.0; }
                  { proportion = 1.0 / 2.0; }
                  { proportion = 2.0 / 3.0; }
                  { proportion = 3.0 / 3.0; }
                ];
              };

              binds = {
                "XF86AudioRaiseVolume".spawn = [
                  "noctalia"
                  "msg"
                  "volume-up"
                ];

                "XF86AudioLowerVolume".spawn = [
                  "noctalia"
                  "msg"
                  "volume-down"
                ];

                "XF86AudioMute".spawn = [
                  "noctalia"
                  "msg"
                  "volume-mute"
                ];

                "XF86MonBrightnessUp".spawn = [
                  "noctalia"
                  "msg"
                  "brightness-up"
                ];

                "XF86MonBrightnessDown".spawn = [
                  "noctalia"
                  "msg"
                  "brightness-down"
                ];

                "Mod+Return".spawn = [ "kitty" ];

                "Mod+D".close-window = { };

                # Focus: windows
                "Mod+H".focus-column-left = { };
                "Mod+L".focus-column-right = { };
                "Mod+K".focus-window-or-workspace-up = { };
                "Mod+J".focus-window-or-workspace-down = { };

                # Focus: monitors
                "Mod+Ctrl+H".focus-monitor-left = { };
                "Mod+Ctrl+L".focus-monitor-right = { };

                # Overview
                "Mod+O" = {
                  _props.repeat = false;
                  toggle-overview = { };
                };

                # Move
                "Mod+Shift+H".move-column-left = { };
                "Mod+Shift+L".move-column-right = { };
                "Mod+Shift+K".move-column-to-workspace-up = { };
                "Mod+Shift+J".move-column-to-workspace-down = { };

                # Column widths
                "Mod+Shift+F".fullscreen-window = { };

                "Mod+1".set-column-width = "25%";
                "Mod+2".set-column-width = "50%";
                "Mod+3".set-column-width = "75%";
                "Mod+4".set-column-width = "100%";

                "Mod+R".switch-preset-column-width = { };

                "Mod+Minus".set-column-width = "-10%";
                "Mod+Equal".set-column-width = "+10%";

                "Mod+F".maximize-column = { };
                "Mod+C".center-column = { };

                # Floating windows
                "Mod+V".toggle-window-floating = { };
                "Mod+Shift+V".switch-focus-between-floating-and-tiling = { };

                # Noctalia
                "Mod+Space".spawn = [
                  "noctalia"
                  "msg"
                  "panel-toggle"
                  "launcher"
                ];

                "Mod+S".spawn = [ "${create-screenshot}" ];
              };

              animations = {
                slowdown = 2.0;

                window-open = {
                  duration-ms = 260;

                  curve._args = [
                    "cubic-bezier"
                    0.22
                    1.0
                    0.36
                    1.0
                  ];

                  custom-shader = ''
                    vec4 open_color(vec3 coords_geo, vec3 size_geo) {
                        float p = niri_clamped_progress;

                        // Slight up-to-down settle.
                        float slide_px = (1.0 - p) * 60.0;
                        float slide_geo = slide_px / max(size_geo.x, 1.0);

                        // Very subtle scale-up into place.
                        float scale = 0.985 + 0.015 * p;

                        vec2 uv = coords_geo.xy;
                        uv -= vec2(0.5, 0.5);
                        uv /= scale;
                        uv += vec2(0.5, 0.5);

                        uv.y -= slide_geo;

                        vec3 coords_tex = niri_geo_to_tex * vec3(uv, 1.0);
                        vec4 color = texture2D(niri_tex, coords_tex.st);

                        // Gentle fade-in.
                        color *= p;

                        return color;
                    }
                  '';
                };

                window-close = {
                  duration-ms = 260;

                  curve._args = [
                    "cubic-bezier"
                    0.32
                    0.0
                    0.67
                    0.0
                  ];

                  custom-shader = ''
                        vec4 close_color(vec3 coords_geo, vec3 size_geo) {
                        float p = niri_clamped_progress;
                        float inv = 1.0 - p;

                        // Slight downward departure.
                        float slide_px = p * 40.0;
                        float slide_geo = slide_px / max(size_geo.x, 1.0);

                        // Tiny scale-down on exit.
                        float scale = 1.0 - 0.012 * p;

                        vec2 uv = coords_geo.xy;
                        uv -= vec2(0.5, 0.5);
                        uv /= scale;
                        uv += vec2(0.5, 0.5);

                        uv.y -= slide_geo;

                        vec3 coords_tex = niri_geo_to_tex * vec3(uv, 1.0);
                        vec4 color = texture2D(niri_tex, coords_tex.st);

                        color *= inv;
                        return color;
                    }
                  '';
                };

                window-resize = {
                  spring._props = {
                    damping-ratio = 1.0;
                    stiffness = 720;
                    epsilon = 0.0001;
                  };

                  custom-shader = ''
                        vec4 resize_color(vec3 coords_curr_geo, vec3 size_curr_geo) {
                        // Show the next texture, but with a very mild softening
                        // toward the edges during motion for a less harsh resize feel.
                        vec3 coords_tex_next = niri_geo_to_tex_next * coords_curr_geo;
                        vec4 color = texture2D(niri_tex_next, coords_tex_next.st);

                        vec2 uv = coords_curr_geo.xy;
                        float edge =
                            min(min(uv.x, 1.0 - uv.x), min(uv.y, 1.0 - uv.y));

                        float vignette = smoothstep(0.0, 0.06, edge);
                        color.rgb *= mix(0.985, 1.0, vignette);

                        return color;
                    }
                  '';
                };

                workspace-switch.spring._props = {
                  damping-ratio = 1.0;
                  stiffness = 760;
                  epsilon = 0.0001;
                };

                horizontal-view-movement.spring._props = {
                  damping-ratio = 1.0;
                  stiffness = 640;
                  epsilon = 0.0001;
                };

                window-movement.spring._props = {
                  damping-ratio = 1.0;
                  stiffness = 700;
                  epsilon = 0.0001;
                };

                config-notification-open-close.spring._props = {
                  damping-ratio = 1.0;
                  stiffness = 820;
                  epsilon = 0.001;
                };

                exit-confirmation-open-close.spring._props = {
                  damping-ratio = 1.0;
                  stiffness = 560;
                  epsilon = 0.01;
                };

                screenshot-ui-open = {
                  duration-ms = 220;

                  curve._args = [
                    "cubic-bezier"
                    0.32
                    0.0
                    0.67
                    0.0
                  ];
                };

                overview-open-close.spring._props = {
                  damping-ratio = 1.0;
                  stiffness = 620;
                  epsilon = 0.0001;
                };

                recent-windows-close.spring._props = {
                  damping-ratio = 1.0;
                  stiffness = 680;
                  epsilon = 0.001;
                };
              };

              _children = [
                {
                  spawn-at-startup._args = [ "noctalia" ];
                }
                {
                  spawn-at-startup._args = [
                    "nm-applet"
                    "--indicator"
                  ];
                }

                {
                  layer-rule._children = [
                    {
                      match._props.namespace = "^noctalia-backdrop";
                    }
                    {
                      place-within-backdrop = true;
                    }
                  ];
                }

                {
                  window-rule._children = [
                    {
                      draw-border-with-background = false;
                    }
                    {
                      geometry-corner-radius = 5.0;
                    }
                    {
                      clip-to-geometry = true;
                    }
                  ];
                }

                {
                  window-rule._children = [
                    {
                      match._props.app-id = "dev.noctalia.Noctalia";
                    }
                    {
                      open-floating = true;
                    }
                    {
                      default-column-width.fixed = 1080;
                    }
                    {
                      default-window-height.fixed = 920;
                    }
                  ];
                }

                {
                  window-rule._children = [
                    {
                      match._props.app-id = "librewolf";
                    }
                    {
                      open-maximized = true;
                    }
                  ];
                }

                {
                  window-rule._children = [
                    {
                      match._props.app-id = "firefox";
                    }
                    {
                      open-maximized = true;
                    }
                  ];
                }

                {
                  window-rule._children = [
                    {
                      match._props.app-id = "brave-browser";
                    }
                    {
                      open-maximized = true;
                    }
                  ];
                }
              ];
            };
          };
        };
      };
  };
}
