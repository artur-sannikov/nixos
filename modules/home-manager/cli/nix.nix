{ pkgs, ... }:
{
  home.packages = with pkgs; [
    cachix
    nixfmt-rfc-style
    nixd
  ];
}
