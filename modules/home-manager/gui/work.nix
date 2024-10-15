{ pkgs, ... }:
{
  imports = [
    ./common.nix
    ./thunderbird.nix
  ];
  # Work apps
  home.packages = with pkgs; [
    slack
    teams-for-linux
    openconnect
    quickemu
  ];
}
