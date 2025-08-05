{ pkgs, ... }:
{
  imports = [
    ./plugins
  ];
  programs.nixvim = {
    enable = true;
  };
}
