{ inputs, ... }:
{
  flake.modules = {
    nixos.niri =
      { pkgs, ... }:
      {
        imports = [ inputs.niri.nixosModules.niri ];
        # Required for Niri
        xdg = {
          portal = {
            enable = true;
            extraPortals = with pkgs; [
              xdg-desktop-portal-gtk
              xdg-desktop-portal-gnome
            ];
            config = {
              niri = {
                default = [
                  "gtk"
                  "gnome"
                ];
              };
            };
            xdgOpenUsePortal = true;
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
          niri = {
            enable = true;
          };
        };
      };

    homeManager.niri =
      {
        pkgs,
        lib,
        ...
      }:
      {
        programs = {
          niri = {
            settings = {
              prefer-no-csd = true;
              # Xwayland
              xwayland-satellite = {
                enable = true;
                path = lib.getExe pkgs.xwayland-satellite;
              };
              spawn-at-startup = [
                # { command = [ "noctalia" ]; }
                {
                  command = [
                    "nm-applet" # Save wifi passwords between sessions
                    "--indicator"
                  ];
                }
              ];
              input = {
                keyboard = {
                  xkb = {
                    layout = "us,ru,fi";
                  };
                };
              };
              layout = {
                gaps = 5;
                preset-column-widths = [
                  { proportion = 1. / 3.; }
                  { proportion = 1. / 2.; }
                  { proportion = 2. / 3.; }
                  { proportion = 3. / 3.; }
                ];
              };

              binds = {
                "Mod+Return".action.spawn = [ "kitty" ];
                # Note for future me:
                # D is more natural for me because that's how I also close
                # terminal windows
                "Mod+D".action.close-window = [ ];

                ### Focus ###

                # Windows
                "Mod+H".action.focus-column-left = [ ];
                "Mod+L".action.focus-column-right = [ ];
                "Mod+K".action.focus-window-or-workspace-up = [ ];
                "Mod+J".action.focus-window-or-workspace-down = [ ];

                # Overview
                "Mod+O" = {
                  repeat = false;
                  action.toggle-overview = [ ];
                };

                # Move
                "Mod+Shift+H".action.move-column-left = [ ];
                "Mod+Shift+L".action.move-column-right = [ ];
                "Mod+Shift+K".action.move-column-to-workspace-up = [ ];
                "Mod+Shift+J".action.move-column-to-workspace-down = [ ];

                # Width of columns
                "Mod+Shift+F".action.fullscreen-window = [ ];
                "Mod+1".action.set-column-width = "25%";
                "Mod+2".action.set-column-width = "50%";
                "Mod+3".action.set-column-width = "75%";
                "Mod+4".action.set-column-width = "100%";

                "Mod+R".action.switch-preset-column-width = [ ];

                "Mod+Minus".action.set-column-width = "-10%";
                "Mod+Equal".action.set-column-width = "+10%";

                "Mod+F".action.maximize-column = [ ];
                "Mod+C".action.center-column = [ ];

                # Floating window
                "Mod+V".action.toggle-window-floating = [ ];
                "Mod+Shift+V".action.switch-focus-between-floating-and-tiling = [ ];

                # Noctalia bindings
                "Mod+Space".action.spawn = [
                  "noctalia"
                  "msg"
                  "panel-toggle"
                  "launcher"
                ];

                "Mod+S".action.spawn = [
                  "noctalia"
                  "msg"
                  "settings-toggle"
                ];
              };

              window-rules = [
                {
                  # Fix tinted background when using stylix
                  draw-border-with-background = false;

                  # Rounded corners
                  geometry-corner-radius = {
                    top-left = 5.0;
                    top-right = 5.0;
                    bottom-right = 5.0;
                    bottom-left = 5.0;
                  };
                  clip-to-geometry = true;
                }
                {
                  matches = [ { app-id = "librewolf"; } ];
                  open-maximized = true;
                }
                {
                  matches = [ { app-id = "firefox"; } ];
                  open-maximized = true;
                }
              ];
              layer-rules = [
                {
                  # Blurred wallpaper in the overview
                  matches = [ { namespace = "^noctalia-backdrop"; } ];
                  place-within-backdrop = true;
                }

              ];
              animations = {
                slowdown = 2.0; # Adjust the speed of the animation
                # Credits to https://github.com/jgarza9788/niri-animation-collection
                /*
                  Title: glide
                  Authors: Justin Garza <JGarza9788@gmail.com>
                  Desc: a softer Apple-like glide preset for niri.
                  Demo: ./demos/glide.gif
                  Notes:
                  - Smooth, polished, low-bounce motion.
                  - Open is slightly more luxurious than close.
                  - Uses custom shaders where niri supports them.
                */

                window-open = {
                  kind.easing = {
                    duration-ms = 260;
                    curve = "cubic-bezier";
                    curve-args = [
                      0.22
                      1.0
                      0.36
                      1.0
                    ];
                  };

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
                  kind.easing = {
                    duration-ms = 180;
                    curve = "cubic-bezier";
                    curve-args = [
                      0.32
                      0.0
                      0.67
                      0.0
                    ];
                  };

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
                  kind.spring = {
                    damping-ratio = 1.0;
                    stiffness = 720;
                    epsilon = 0.0001;
                  };

                  custom-shader = ''
                    vec4 resize_color(vec3 coords_curr_geo, vec3 size_curr_geo) {
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

                workspace-switch.kind.spring = {
                  damping-ratio = 1.0;
                  stiffness = 760;
                  epsilon = 0.0001;
                };

                horizontal-view-movement.kind.spring = {
                  damping-ratio = 1.0;
                  stiffness = 640;
                  epsilon = 0.0001;
                };

                window-movement.kind.spring = {
                  damping-ratio = 1.0;
                  stiffness = 700;
                  epsilon = 0.0001;
                };

                config-notification-open-close.kind.spring = {
                  damping-ratio = 1.0;
                  stiffness = 820;
                  epsilon = 0.001;
                };

                exit-confirmation-open-close.kind.spring = {
                  damping-ratio = 1.0;
                  stiffness = 560;
                  epsilon = 0.01;
                };

                screenshot-ui-open.kind.easing = {
                  duration-ms = 220;
                  curve = "cubic-bezier";
                  curve-args = [
                    0.22
                    1.0
                    0.36
                    1.0
                  ];
                };

                overview-open-close.kind.spring = {
                  damping-ratio = 1.0;
                  stiffness = 620;
                  epsilon = 0.0001;
                };

                # not implemented yet
                # recent-windows-close.kind.spring = {
                #   damping-ratio = 1.0;
                #   stiffness = 680;
                #   epsilon = 0.001;
                # };
              };
            };
          };
        };
      };
  };
}
