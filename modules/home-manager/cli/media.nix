{ pkgs-unstable, ... }:
{
  home.packages = with pkgs-unstable; [
    ffmpeg-full
    mediainfo
    sox
  ];
}
