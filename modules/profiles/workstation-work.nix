{ inputs, self, ... }:
{
  flake.modules.nixos.workstation-work = {
    imports = with inputs.self.modules.nixos; [
      workstation # Common stuff between personal and work
      samba # For printing and stuff
      xremap
    ];
    home-manager.users.artur.imports = with self.modules.homeManager; [
      gui-work
    ];
  };
  flake.modules.homeManager.workstation-work = {
    wayland.windowManager = {
      niri = {
        settings = {
          _children = [
            {
              output = {
                _args = [ "eDP-1" ];
                mode = "1920x1080@60.002";
                scale = 1.25;
                position._props = {
                  x = 0;
                  y = 0;
                };
              };
            }
            {
              output = {
                _args = [ "HDMI-A-1" ];

                mode = "1920x1080@74.973";

                position._props = {
                  x = 1536; # Logical pixels: 1920 / 1.25
                  y = 0;
                };
              };
            }
            {
              output = {
                _args = [ "DP-5" ];

                mode = "1920x1080@74.973";

                position._props = {
                  x = 3456; # 1536 + 1920
                  y = 0;
                };
              };
            }
          ];
        };
      };
    };
  };
}
