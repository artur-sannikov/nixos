{ pkgs, pkgs-stable, ... }:
{
  home.packages =
    with pkgs;
    [
      age
      ansible
      ansible-lint
      beets-unstable
      black
      caddy
      devenv
      distrobox
      gnumake
      isort
      jdk
      kubectl
      lynx
      mat2
      micromamba
      nextflow
      podlet
      python312Packages.huggingface-hub
      python312Packages.radian
      python312Packages.pip
      screen
      shellcheck
      shfmt
      sops
      talosctl
      toolbox
      typst
      virtualenv
      wl-clipboard-rs
    ]
    ++ (with pkgs-stable; [
      quarto
    ]);
}
