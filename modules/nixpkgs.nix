{ inputs, self, ... }:
let
  unfreePackages = [
    "corefonts" # Microsoft fonts
    "duplicacy-web"
    "obsidian"
    "slack"
    "steam"
    "steam-unwrapped"
    "via"
    "vista-fonts"
    "wezterm.nvim"
    "zoom"
  ];

  nixpkgsConfig = {
    allowUnfreePredicate = pkg: builtins.elem (inputs.nixpkgs.lib.getName pkg) unfreePackages;
  };

  overlays = [
    (final: _: {
      stable = import inputs.nixpkgs-stable {
        inherit (final.stdenv.hostPlatform) system;
        config = nixpkgsConfig;
      };
      master = import inputs.nixpkgs-master {
        inherit (final.stdenv.hostPlatform) system;
        config = nixpkgsConfig;
      };
      podman-old = import inputs.nixpkgs-podman {
        inherit (final.stdenv.hostPlatform) system;
      };
    })
  ]
  ++ builtins.attrValues self.overlays;
in
{
  flake.modules.nixos.nixpkgs = {
    nixpkgs.overlays = overlays;
    nixpkgs.config = nixpkgsConfig;
  };

  perSystem =
    { system, ... }:
    {
      _module.args.pkgs = import inputs.nixpkgs {
        inherit system overlays;
        config = nixpkgsConfig;
      };
    };
}
