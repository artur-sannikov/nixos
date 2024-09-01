{ pkgs-unstable, ... }:
{
  home.packages = with pkgs-unstable; [
    cachix
    nixfmt-rfc-style
    nixd
  ];
}
