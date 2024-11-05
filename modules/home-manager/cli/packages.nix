{ pkgs, flake-inputs, ... }:
{
  home.packages = with pkgs; [
    age
    ansible
    ansible-lint
    beets-unstable
    caddy
    distrobox
    gnumake
    quarto
    python312Packages.radian
    kubectl
    talosctl
    typst
    screen
    mat2
    sops
    wl-clipboard-rs
    flake-inputs.podlet.packages."${pkgs.system}".podlet
  ];
}
