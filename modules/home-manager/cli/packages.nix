{ pkgs, ... }:
{
  home.packages = with pkgs; [
    ansible
    ansible-lint
    pandoc
    cachix
    nixd
    screen
  ];
}
