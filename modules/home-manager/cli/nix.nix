{ pkgs, ... }:
{
  flake.modules.homeModules.cli = {
    home.packages = with pkgs; [
      cachix
      nixfmt
      nixd
    ];
  };
}
