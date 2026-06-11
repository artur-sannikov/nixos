{ pkgs, ... }:
{
  flake.modules.homeModules.cli = {
    programs = {
      yt-dlp = {
        enable = true;
        settings = {
          embed-metadata = true;
          embed-subs = true;
          embed-thumbnail = true;
        };
      };
    };
    home.packages = [ pkgs.aria2 ];
  };
}
