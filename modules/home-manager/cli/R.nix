{ pkgs, ... }:
{
  home.packages = [
    pkgs.R
    pkgs.rPackages.languageserver
  ];
}
