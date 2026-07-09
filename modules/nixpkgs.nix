# { inputs, self, ... }:
# {
#   flake.modules.nixos.nixpkgs = {
#     nixpkgs.overlays = [
#       (final: _: {
#         stable = import inputs.nixpkgs-stable {
#           inherit (final.stdenv.hostPlatform) system;
#           config.allowUnfree = true;
#         };
#       })
#     ]
#     # Needed to add this to make duplicacy-web work (which is an overlay)
#     ++ builtins.attrValues self.overlays;
#     nixpkgs.config.allowUnfreePredicate =
#       pkg:
#       builtins.elem (inputs.nixpkgs.lib.getName pkg) [
#         "duplicacy-web"
#         "obsidian"
#         "slack"
#         "steam"
#         "steam-unwrapped"
#         "via"
#         "wezterm.nvim"
#         "zoom"
#       ];
#   };
# }

{ inputs, self, ... }:
let
  unfreePackages = [
    "duplicacy-web"
    "obsidian"
    "slack"
    "steam"
    "steam-unwrapped"
    "via"
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
        config.allowUnfree = true;
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
