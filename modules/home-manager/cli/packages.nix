{ pkgs-unstable, flake-inputs, ... }:
{
  home.packages = with pkgs-unstable; [
    ansible
    ansible-lint
    distrobox
    gnumake
    quarto
    screen
    flake-inputs.podlet.packages."${pkgs-unstable.system}".podlet
  ];
}
