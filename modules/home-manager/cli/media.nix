{ pkgs, ... }:
{
  flake.modules.homeModules.cli = {
    home.packages = with pkgs; [
      ffmpeg-full
      flac
      mediainfo
      sox
    ];
  };
}
