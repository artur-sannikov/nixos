{
  lib,
  config,
  pkgs-unstable,
  ...
}:
with lib;
let
  cfg = config.yt-dlp;
in

{
  options.yt-dlp = {
    enable = mkOption {
      type = types.bool;
      default = false;
      description = "Enable yt-dlp";
    };
  };
  config = mkIf cfg.enable {
    programs = {
      yt-dlp = {
        enable = true;
      };
    };
    home.packages = [ pkgs-unstable.aria2 ];
  };
}
