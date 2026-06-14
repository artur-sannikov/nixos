{ inputs, ... }:
{
  flake.modules.nixos.base = {
    imports = with inputs.self.modules.nixos; [
      earlyloom
      nix-maintenance
      nixpkgs
      sops
      sudo
      users
    ];
    system = {
      stateVersion = "24.05";
    };
  };
}
