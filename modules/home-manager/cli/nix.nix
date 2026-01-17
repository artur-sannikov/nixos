{ pkgs, ... }:
{
  home.packages = with pkgs; [
    cachix
    nixfmt
    nixd
  ];
}
