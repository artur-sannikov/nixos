{ pkgs, ... }:
{
  home.packages = with pkgs; [
    age
    ansible
    ansible-lint
    beets-unstable
    caddy
    devenv
    distrobox
    gnumake
    kubectl
    lynx
    mat2
    nextflow
    podlet
    python312Packages.huggingface-hub
    python312Packages.radian
    quarto
    screen
    sops
    talosctl
    toolbox
    typst
    wl-clipboard-rs
  ];
}
