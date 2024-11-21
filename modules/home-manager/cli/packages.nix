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
    lynx
    gnumake
    python312Packages.huggingface-hub
    kubectl
    mat2
    podlet
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
