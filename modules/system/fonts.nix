{ pkgs, ... }:
{
  fonts.packages = with pkgs; [
    nerd-fonts.iosevka
    source-code-pro
    open-sans
  ];
}
