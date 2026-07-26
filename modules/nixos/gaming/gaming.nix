{ config, inputs, ... }:
{
  flake.modules.nixos.gaming = {
    imports = with config.flake.modules.nixos; [
      inputs.nix-gaming.nixosModules.platformOptimizations
      gaming-packages
      steam
    ];
    nix = {
      settings = {
        substituters = [ "https://nix-gaming.cachix.org" ];
        trusted-public-keys = [ "nix-gaming.cachix.org-1:nbjlureqMbRAxR1gJ/f3hxemL9svXaZF/Ees8vCUUs4=" ];
      };
    };
  };
}
