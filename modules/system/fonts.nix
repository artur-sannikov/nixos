{ pkgs, ... }:
{
  fonts.packages = [
    pkgs.nerd-fonts.iosevka
    pkgs.source-code-pro
  ];
}
