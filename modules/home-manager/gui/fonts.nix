{ pkgs, ... }:
{
  home.packages = with pkgs; [
    iosevka
  ];
  fonts.fontconfig.enable = true;
}
