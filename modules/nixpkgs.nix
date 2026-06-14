{ inputs, ... }:
{
  flake.modules.nixos.nixpkgs = { lib, pkgs, ... }: {
    _module.args.pkgs-stable = import inputs.nixpkgs-stable {
      inherit (pkgs.stdenv.hostPlatform) system;
    };
    nixpkgs.config.allowUnfreePredicate =
      pkg:
      builtins.elem (lib.getName pkg) [
        "zoom"
        "obsidian"
      ];
  };
}
