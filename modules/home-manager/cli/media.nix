{ pkgs-unstable, ... }:
{
  home.packages = with pkgs-unstable; [
    ffmpeg
    mediainfo
    sox
  ];
}
