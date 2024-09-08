{ pkgs-unstable, ... }:
{
  programs = {
    appimage = {
      enable = true;
      binfmt = true;
    };
  };
  environment.systemPackages = with pkgs-unstable; [
    appimage-run
    libappimage
  ];
}
