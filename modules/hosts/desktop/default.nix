{
  self,
  inputs,
  ...
}:
let
  system = "x86_64-linux";
  username = "artur";
in
{
  flake = {
    nixosConfigurations.desktop = inputs.nixpkgs.lib.nixosSystem {
      inherit system;
      specialArgs = {
        inherit username;
      };
      modules = [
        # Host-specific hardware and disk configurations
        ./_disko.nix
        ./_hardware-configuration.nix
        ./_boot.nix
        self.modules.nixos.base
        self.modules.nixos.users-artur
        self.modules.nixos.workstation-personal
        self.modules.nixos.desktop
        inputs.disko.nixosModules.disko
        inputs.lanzaboote.nixosModules.lanzaboote
      ];
    };
  };
}
