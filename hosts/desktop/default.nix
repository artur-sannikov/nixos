{
  self,
  inputs,
  config,
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
  flake.nixosConfigurations.desktop = inputs.nixpkgs.lib.nixosSystem {
    inherit system pkgs;
    specialArgs = {
      flake-inputs = inputs;
      inherit username pkgs-stable;
    };
    modules = [
      ../../hosts/desktop/configuration.nix
      self.modules.nixosModules.base
      self.modules.nixosModules.secureBoot
      self.modules.nixosModules.libvird
      self.modules.nixosModules.bottles
      self.modules.nixosModules.gaming
      self.modules.nixosModules.keyboard
      inputs.disko.nixosModules.disko
      # inputs.home-manager.nixosModules.home-manager
      inputs.home-manager.flakeModules.home-manager
      inputs.stylix.nixosModules.stylix
      inputs.lanzaboote.nixosModules.lanzaboote
      (import ../../overlay.nix)
      {
        home-manager = {
          useGlobalPkgs = true;
          useUserPackages = true;
          users.${username}.imports = [
            ../../hosts/desktop/home.nix
            self.homeModules.base
            self.homeModules.gui
            self.homeModules.email
            self.homeModules.contact
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
