{
  self,
  inputs,
  config,
  withSystem,
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
  # pkgs = import inputs.nixpkgs {
  #   inherit system;
  # };
  # pkgs-stable = import inputs.nixpkgs-stable { inherit system; };
in
{
  imports = [
    inputs.home-manager.flakeModules.home-manager
  ];
  flake = {
    nixosConfigurations.desktop = inputs.nixpkgs.lib.nixosSystem {
      inherit system;
      specialArgs = {
        # flake-inputs = inputs;
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
        # {
        #   home-manager.users.artur.imports = with self.modules.homeManager; [
        #     email
        #     email-personal
        #     gui-personal
        #   ];
        # }
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
        #     users = {
        #       ${username} = {
        #         imports = with self.modules.homeManager; [
        #           # ../../hosts/desktop/home.nix
        #           # base
        #           # self.modules.homeModules.gui
        #           # self.modules.homeModules.cli
        #           # self.modules.homeModules.personal-cli
        #           # self.modules.homeModules.personal
        #           # self.modules.homeModules.email
        #           # self.modules.homeModules.personal-email
        #           # self.modules.homeModules.contact
        #           # self.modules.homeModules.stylix
        #         ];
        #       };
        #     };
        #   };
        # }
      ];
    };
  };
}
