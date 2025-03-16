{ pkgs, pkgs-stable, ... }:
{
  home.packages =
    with pkgs;
    [
      act
      age
      ansible
      ansible-lint
      black
      beets
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
      opentofu
      podlet
      python312Packages.huggingface-hub
      python312Packages.pip
      python312Packages.radian
      sass
      screen
      shellcheck
      shfmt
      sops
      talosctl
      terraform
      toolbox
      typst
      virtualenv
      wl-clipboard-rs
    ]
    ++ (with pkgs-stable; [
      quarto
    ]);
}
