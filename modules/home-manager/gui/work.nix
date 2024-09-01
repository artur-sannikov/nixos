{ pkgs, ... }:
{
  imports = [
    ./common.nix
  ];
  # Work apps
  home.packages = with pkgs; [
    slack
    teams-for-linux
  ];
}
