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
      toolbox
      typst
      virtualenv
      wl-clipboard-rs
    ]
    ++ (with pkgs-stable; [
      beets
      quarto
    ]);
}
