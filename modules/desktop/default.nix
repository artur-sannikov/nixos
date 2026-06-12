{
  self,
  inputs,
  config,
  ...
}:
let
  system = "x86_64-linux";
  username = "artur";
  hmModules = with self.modules.homeModules; [
    base
    # niri

    # Apps
  ];
  pkgs = import inputs.nixpkgs { inherit system; };
  pkgs-stable = import inputs.nixpkgs-stable { inherit system; };
  lib = config.flake.lib;
in
{
  imports = [
    inputs.home-manager.flakeModules.home-manager
  ];
  flake = {
    nixosConfigurations.desktop = inputs.nixpkgs.lib.nixosSystem {
      inherit system pkgs;
      specialArgs = {
        # flake-inputs = inputs;
        inherit username pkgs-stable;
      };
      modules = [
        # Host-specific hardware and disk configurations
        ./_disko.nix
        ./_hardware-configuration.nix
        ./_boot.nix
        self.modules.nixosModules.cli
        # self.modules.nixosModules.base
        # self.modules.nixosModules.fonts
        # self.modules.nixosModules.secureBoot
        # self.modules.nixosModules.bottles
        # self.modules.nixosModules.gaming
        # self.modules.nixosModules.ollama-rocm
        # self.modules.nixosModules.audio
        # self.modules.nixosModules.nvme
        # self.modules.nixosModules.keyboard
        # self.modules.nixosModules.attic-watch-store
        # self.modules.nixosModules.stylix
        # self.modules.nixosModules.gui
        # self.modules.nixosModules.virtualization
        # self.modules.nixosModules.sillytavern
        # self.modules.nixosModules.ssh
        # self.modules.nixosModules.immich-machine-learning
        # self.modules.nixosModules.nix
        # self.modules.nixosModules.nix-maintenance
        # self.modules.nixosModules.syncthing
        # self.modules.nixosModules.email
        # self.modules.nixosModules.timezone-static
        inputs.disko.nixosModules.disko
        # inputs.home-manager.nixosModules.home-manager
        # inputs.home-manager.flakeModules.home-manager
        inputs.stylix.nixosModules.stylix
        inputs.lanzaboote.nixosModules.lanzaboote
        (import ../../overlay.nix)
        # {
        #   home-manager = {
        #     useGlobalPkgs = true;
        #     useUserPackages = true;
        #     users.${username}.imports = [
        # ../../hosts/desktop/home.nix
        # self.modules.homeModules.base
        # self.modules.homeModules.gui
        # self.modules.homeModules.cli
        # self.modules.homeModules.personal-cli
        # self.modules.homeModules.personal
        # self.modules.homeModules.email
        # self.modules.homeModules.personal-email
        # self.modules.homeModules.contact
        # self.modules.homeModules.stylix
        # ];
        # };
        # }
      ];
    };
    homeConfigurations.desktop = inputs.home-manager.lib.homeManagerConfiguration {
      inherit pkgs;
      extraSpecialArgs = { inherit inputs self username; };
      modules = [ self.modules.homeModules.base ];
    };
  };
}
