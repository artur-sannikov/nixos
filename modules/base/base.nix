{ inputs, ... }:
{
  flake.modules.nixos.base = {
    imports = with inputs.self.modules.nixos; [
      earlyloom
      nix-maintenance
      nixpkgs
      sops
    ];
    system = {
      stateVersion = "24.05";
    };
  };
}
