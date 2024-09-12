{ pkgs, ... }:
{
  home.packages = with pkgs; [
    inter
    iosevka
    liberation_ttf
    source-serif-pro
  ];
  fonts.fontconfig.enable = true;
}
