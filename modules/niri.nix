{ inputs, ... }:
{
  flake.modules = {
    nixos.niri = {
      imports = [ inputs.niri.nixosModules.niri ];
      programs = {
        niri = {
          enable = true;
        };
      };
    };
    homeManager.niri = { pkgs, lib, ... }: {
      programs.niri = {
        settings = {
          spawn-at-startup = [
            { command = [ "noctalia" ]; }
          ];
          input = {
            mod-key = "Ctrl"; # Bound to Caps Lock in my case
            keyboard = {
              xkb = {
                layout = "us";
              };
            };
          };
          layout = {
            gaps = 5;
          };

          binds = {
            "Mod+Return" = {
              action = {
                spawn-sh = lib.getExe pkgs.kitty;
              };
            };
            # Focus
            "Mod+H".action.focus-column-left = [ ];
            "Mod+L".action.focus-column-right = [ ];
            "Mod+K".action.focus-window-up = [ ];
            "Mod+J".action.focus-window-down = [ ];

            # Move
            "Mod+Shift+H".action.move-column-left = [ ];
            "Mod+Shift+L".action.move-column-right = [ ];
            "Mod+Shift+K".action.move-window-up = [ ];
            "Mod+Shift+J".action.move-window-down = [ ];
          };
        };
      };
    };
  };
}
