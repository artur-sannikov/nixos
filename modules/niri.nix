{ inputs, ... }:
{
  flake.modules = {
    nixos.niri = {
      imports = [ inputs.niri.nixosModules.niri ];
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
      { pkgs, lib, ... }:
      {
        programs = {
          fuzzel = {
            enable = true;
            settings = {
              main = {
                terminal = "kitty";
                font = lib.mkForce "monospace:size=16";
              };
            };
          };
          niri = {
            settings = {
              prefer-no-csd = true;
              # Xwayland
              xwayland-satellite = {
                enable = true;
                path = lib.getExe pkgs.xwayland-satellite;
              };
              spawn-at-startup = [
                { command = [ "noctalia" ]; }
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
              };

              binds = {
                "Mod+Return".action.spawn = [ "kitty" ];
                "Mod+D".action.spawn = [ "fuzzel" ];

                "Mod+Q".action.close-window = [ ];

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

                "Mod+Minus".action.set-column-width = "-10%";
                "Mod+Equal".action.set-column-width = "+10%";

                "Mod+F".action.maximize-column = [ ];

                # Floating window
                "Mod+V".action.toggle-window-floating = [ ];
                "Mod+Shift+V".action.switch-focus-between-floating-and-tiling = [ ];
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
                  matches = [ { namespace = "^launcher$"; } ];
                  opacity = 0.9;
                  # Blurred wallpaper in the overview
                  matches = [ { namespace = "^noctalia-backdrop"; } ];
                  place-within-backdrop = true;
                }
              ];
            };
          };
        };
      };
  };
}
