{ pkgs-unstable, ... }:
{
  home.packages = with pkgs-unstable; [
    ansible
    ansible-lint
    distrobox
    gnumake
    texlive.combined.scheme-medium
    texstudio
    quarto
  ];
}
