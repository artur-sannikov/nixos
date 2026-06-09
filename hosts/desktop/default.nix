{
  self,
  inputs,
  config,
  lib,
  ...
}:
let
  system = "x86_64-linux";
  username = "artur";
  pkgs = import inputs.nixpkgs { inherit system; };
  pkgs-stable = import inputs.nixpkgs-stable { inherit system; };
  lib = config.flake.lib;
in
{
  flake.nixosConfigurations.desktop = lib.nixosSystem {
    inherit system pkgs;
    specialArgs = {
      flake-inputs = inputs;
      inherit username pkgs-stable;
    };
    modules = [
      ../../hosts/desktop/configuration.nix
      self.nixosModules.base
      inputs.disko.nixosModules.disko
      inputs.home-manager.nixosModules.home-manager
      inputs.stylix.nixosModules.stylix
      inputs.lanzaboote.nixosModules.lanzaboote
      (import ../../overlay.nix)
      {
        home-manager = {
          useGlobalPkgs = true;
          useUserPackages = true;
          users.${username}.imports = [
            ../../hosts/desktop/home.nix
            # config.flake.modules.homeManager.base
            # self.modules.homeManager.base
          ];
          extraSpecialArgs = {
            flake-inputs = inputs;
            inherit pkgs-stable username;
          };
        };
      }
    ];
  };
}
