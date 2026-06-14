{
  flake.modules.homeModules.cli = { pkgs, ... }: {
    programs = {
      yt-dlp = {
        enable = true;
        settings = {
          embed-chapters = true;
          embed-metadata = true;
          embed-subs = true;
          embed-thumbnail = true;
        };
      };
    };
    home.packages = [ pkgs.aria2 ];
  };
}
