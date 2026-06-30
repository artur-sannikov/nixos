{ inputs, ... }:
{
  flake.modules.nixos.base = {
    imports = with inputs.self.modules.nixos; [
      earlyloom
      nix-maintenance
      nixpkgs
      nix
      sops
      sudo
      tailscale
      users
    ];
    system = {
      stateVersion = "24.05";
    };
  };
}
