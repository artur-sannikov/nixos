{ pkgs, ... }:
{
  programs.mpv = {
    enable = true;
    scripts = with pkgs.mpvScripts; [
      sponsorblock
    ];
    config = {
      profile = "high-quality";
      ytdl-format = "bestvideo+bestaudio";
      demuxer-max-bytes = "1000M";
    };
  };
}
