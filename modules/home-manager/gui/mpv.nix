{ pkgs, ... }:
{
  programs.mpv = {
    enable = true;

    package = (
      pkgs.mpv-unwrapped.wrapper {
        scripts = with pkgs.mpvScripts; [
          sponsorblock
        ];
        mpv = pkgs.mpv-unwrapped.override {
          waylandSupport = true;
        };
      }
    );
    config = {
      profile = "high-quality";
      ytdl-format = "bestvideo+bestaudio";
    };
  };

}
