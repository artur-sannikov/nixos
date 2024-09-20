{ pkgs-unstable, flake-inputs, ... }:
{
  home.packages = with pkgs-unstable; [
    ansible
    ansible-lint
    caddy
    distrobox
    gnumake
    quarto
    typst
    screen
    tmux
    wl-clipboard-rs
    flake-inputs.podlet.packages."${pkgs-unstable.system}".podlet
  ];
}
