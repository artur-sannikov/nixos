{ pkgs, ... }:
{
  home.packages = with pkgs; [
    ffmpeg-full
    flac
    mediainfo
    sox
  ];
}
