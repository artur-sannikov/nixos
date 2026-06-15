{ inputs, self, ... }:
{
  flake.modules.nixos.nixpkgs = { pkgs, ... }: {
    nixpkgs.overlays = builtins.attrValues self.overlays;
    _module.args.pkgs-stable = import inputs.nixpkgs-stable {
      inherit (pkgs.stdenv.hostPlatform) system;
    };
    nixpkgs.config.allowUnfreePredicate =
      pkg:
      builtins.elem (inputs.nixpkgs.lib.getName pkg) [
        "duplicacy-web"
        "obsidian"
        "slack"
        "steam"
        "steam-unwrapped"
        "via"
        "zoom"
      ];
  };
}
