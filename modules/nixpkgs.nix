{ inputs, self, ... }:
{
  flake.modules.nixos.nixpkgs = {
    nixpkgs.overlays = [
      (final: _: {
        stable = import inputs.nixpkgs-stable {
          inherit (final.stdenv.hostPlatform) system;
          config.allowUnfree = true;
        };
      })
    ]
    # Needed to add this to make duplicacy-web work (which is an overlay)
    ++ builtins.attrValues self.overlays;
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
