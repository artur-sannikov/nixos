{
  flake.modules.homeManager.niri =
    {
      pkgs,
      lib,
      ...
    }:
    let
      niri-dynamic-float = pkgs.fetchurl {
        url = "https://gist.githubusercontent.com/DerEchteJoghurt/9cabbcf8eb7b4af25e4519feda302cb2/raw/b088b7a319473793f5901d7d0cd2aba37635c3a8/open-float.py";
        hash = "sha256-PBZ0loxWvV5foCJeC+8l4CYR/M6eMO3gcHUHFcuz0C0=";
      };
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
