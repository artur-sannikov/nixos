{
  self,
  inputs,
  lib,
  ...
}:
let
  system = "x86_64-linux";
  username = "artur";
  pkgs = import inputs.nixpkgs { inherit system; };
  pkgs-stable = import inputs.nixpkgs-stable { inherit system; };
in
{
  flake.nixosConfigurations.tuxedo = lib.nixosSystem {
    inherit system pkgs;
    specialArgs = {
      flake-inputs = inputs;
      inherit username pkgs-stable;
    };
    modules = [
      ../../hosts/tuxedo/configuration.nix
      self.nixosModules.base.nixos
      inputs.disko.nixosModules.disko
      inputs.home-manager.nixosModules.home-manager
      inputs.stylix.nixosModules.stylix
      inputs.lanzaboote.nixosModules.lanzaboote
      inputs.home-manager.flakeModules.home-manager
      (import ../../overlay.nix)
      {
        home-manager = {
          useGlobalPkgs = true;
          useUserPackages = true;
          users.${username}.imports = [ ../../hosts/tuxedo/home.nix ];
          extraSpecialArgs = {
            flake-inputs = inputs;
            inherit pkgs-stable username;
          };
        };
      }
    ];
  };
}
