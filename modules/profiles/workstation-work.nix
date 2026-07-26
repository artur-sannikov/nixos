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
    programs.niri.settings = {
      outputs = {
        "eDP-1" = {
          scale = 1.25;
          mode = {
            width = 1920;
            height = 1080;
            refresh = 60.002;
          };
          position = {
            x = 0;
            y = 0;
          };
        };
        "HDMI-A-1" = {
          mode = {
            width = 1920;
            height = 1080;
            refresh = 74.973;
          };
          position = {
            x = 1536; # Logical pixels 1920 / 1.25 (scale of eDP-1)
            y = 0;
          };
        };
        "DP-5" = {
          mode = {
            width = 1920;
            height = 1080;
            refresh = 74.973;
          };
          position = {
            x = 3456; # 1536 + 1920
            y = 0;
          };
        };
      };
    };
  };
}
