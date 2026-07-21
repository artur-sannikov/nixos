# https://github.com/niri-wm/niri/discussions/1599
{
  flake.modules.homeManager.niri =
    {
      pkgs,
      lib,
      ...
    }:
    let
      niri-dynamic-float = ./dynamic-float.py;
    in
    {
      systemd.user.services.niri-dynamic-float = {
        Unit = {
          After = [ "niri.service" ];
        };

        Service = {
          Type = "simple";
          ExecStart = "${lib.getExe pkgs.python3} ${niri-dynamic-float}";
        };

        Install.WantedBy = [ "niri.service" ];
      };
    };
}
