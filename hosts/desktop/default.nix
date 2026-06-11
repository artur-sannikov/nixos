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
      self.modules.nixosModules.ollama-rocm
      self.modules.nixosModules.audio
      self.modules.nixosModules.nvme
      self.modules.nixosModules.keyboard
      self.modules.nixosModules.attic-watch-store
      self.modules.nixosModules.stylix
      self.modules.nixosModules.gui
      self.modules.nixosModules.virtualization
      self.modules.nixosModules.ssh
      self.modules.nixosModules.immich-machine-learning
      self.modules.nixosModules.nix
      self.modules.nixosModules.nix-maintenance
      self.modules.nixosModules.syncthing
      self.modules.nixosModules.email
      self.modules.nixosModules.timezone-static
      inputs.disko.nixosModules.disko
      # inputs.home-manager.nixosModules.home-manager
      inputs.home-manager.flakeModules.home-manager
      inputs.stylix.nixosModules.stylix
      inputs.lanzaboote.nixosModules.lanzaboote
      self.homeModules.email
      (import ../../overlay.nix)
      {
        home-manager = {
          useGlobalPkgs = true;
          useUserPackages = true;
          users.${username}.imports = [
            ../../hosts/desktop/home.nix
            self.homeModules.base
            self.homeModules.gui
            self.homeModules.cli
            self.homeModules.personal-cli
            self.homeModules.personal
            self.homeModules.email
            self.homeModules.personal-email
            self.homeModules.contact
            self.homeModules.stylix
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
