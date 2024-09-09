{ pkgs, ... }:
{
  home.packages = with pkgs; [
    inter
    iosevka
    liberation_ttf
  ];
  fonts.fontconfig.enable = true;
}
