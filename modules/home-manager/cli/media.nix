{ pkgs-unstable, ... }:
{
  home.packages = with pkgs-unstable; [
    ffmpeg-full
    flac
    picard
    mediainfo
    sox
  ];
}
