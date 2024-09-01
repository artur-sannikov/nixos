{
  description = "NixOS configuration";

  inputs = {
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";
    nixpkgs-stable.url = "github:nixos/nixpkgs/nixos-24.05";
    disko.url = "github:nix-community/disko";
    disko.inputs.nixpkgs.follows = "nixpkgs-unstable";
    # home-manager, used for managing user configuration
    home-manager = {
      url = "github:nix-community/home-manager/release-24.05";
      inputs.nixpkgs.follows = "nixpkgs-stable";
    };
    # Declarative Nix Flatpaks
    flatpaks.url = "github:gmodena/nix-flatpak/main";

    # VS Code extensions
    nix-vscode-extensions = {
      url = "github:nix-community/nix-vscode-extensions";
      inputs.nixpkgs.follows = "nixpkgs-unstable";
    };
  };

  outputs =
    inputs@{
      nixpkgs-unstable,
      nixpkgs-stable,
      home-manager,
      # flatpaks,
      nix-vscode-extensions,
      ...
    }:
    let
      system = "x86_64-linux";
      username = "artur";
      lib = nixpkgs-stable.lib;
      pkgs-unstable = import nixpkgs-unstable {
        inherit system;
        # config = {
        #   allowUnfree = true;
        # };
      };
      pkgs = import nixpkgs-stable {
        inherit system;
        # config = {
        #   allowUnfree = true;
        # };
      };
    in
    # pkgs-stable = nixpkgs-stable.legacyPackages.${system};
    # pkgs-unstable = nixpkgs-unstable.legacyPackages.${system};
    {
      nixosConfigurations = {
        vm-ty = lib.nixosSystem {
          inherit system;
          specialArgs = {
            inherit inputs;
            inherit pkgs;
            inherit pkgs-unstable;
          };
          modules = [
            ./hosts/vm-ty/configuration.nix
            inputs.disko.nixosModules.disko
            # make home-manager as a module of nixos
            # so that home-manager configuration will be deployed automatically when executing `nixos-rebuild switch`
            home-manager.nixosModules.home-manager
            {
              inherit pkgs;
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;

              home-manager.users."${username}" = import ./hosts/vm-ty/home.nix;

              # Optionally, use home-manager.extraSpecialArgs to pass arguments to home.nix
              home-manager.extraSpecialArgs = {
                flake-inputs = inputs;
                inherit pkgs-unstable;
              };
            }
          ];
        };
      };
      homeConfigurations."ty" = home-manager.lib.homeManagerConfiguration {
        inherit pkgs;
        extraSpecialArgs = {
          inherit pkgs-unstable;
          flake-inputs = inputs;
        };
        modules = [
          ./hosts/ty/home.nix
          # flatpaks.homeManagerModules.nix-flatpak
          {
            nixpkgs.overlays = [
              nix-vscode-extensions.overlays.default
            ];
          }
        ];
      };
    };
}
