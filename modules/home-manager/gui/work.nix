{ pkgs-stable, ... }:

{
  imports = [
    ./common.nix
  ];
  # Work apps
  home.packages = with pkgs-stable; [
    slack
    teams-for-linux
  ];
}
