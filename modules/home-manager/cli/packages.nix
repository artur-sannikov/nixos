{ pkgs-unstable, flake-inputs, ... }:
{
  home.packages = with pkgs-unstable; [
    age
    ansible
    ansible-lint
    caddy
    distrobox
    gnumake
    quarto
    quickemu
    kdePackages.kcalc
    kubectl
    python312Packages.radian
    talosctl
    typst
    screen
    sops
    ssh-audit
    wl-clipboard-rs
    flake-inputs.podlet.packages."${pkgs-unstable.system}".podlet
  ];
}
