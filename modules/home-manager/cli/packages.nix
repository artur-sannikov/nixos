{ pkgs, ... }:
{
  home.packages = with pkgs; [
    age
    ansible
    ansible-lint
    beets-unstable
    caddy
    distrobox
    gnumake
    kubectl
    mat2
    podlet
    python312Packages.radian
    quarto
    screen
    sops
    talosctl
    typst
    wl-clipboard-rs
  ];
}
