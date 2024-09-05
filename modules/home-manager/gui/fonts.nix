{ pkgs, ... }:
{
  home.packages = with pkgs; [
    iosevka
    liberation_ttf
  ];
  fonts.fontconfig.enable = true;
}
