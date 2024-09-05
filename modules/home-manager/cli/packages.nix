{ pkgs-unstable, ... }:
{
  home.packages = with pkgs-unstable; [
    ansible
    ansible-lint
    distrobox
    gnumake
    quarto
    screen
  ];
}
