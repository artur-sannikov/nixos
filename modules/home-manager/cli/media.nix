{ pkgs-unstable, ... }:
{
  home.packages = with pkgs-unstable; [
    ffmpeg-full
    flac
    flacon
    picard
    mediainfo
    sox
  ];
}
