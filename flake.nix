{
  description = "NixOS configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    disko.url = "github:nix-community/disko";
    disko.inputs.nixpkgs.follows = "nixpkgs";
    # home-manager, used for managing user configuration
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # Declarative Nix Flatpaks
    nix-flatpak.url = "github:gmodena/nix-flatpak";

    # VS Code extensions
    nix-vscode-extensions = {
      url = "github:nix-community/nix-vscode-extensions";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    inputs@{
      nixpkgs,
      home-manager,
      nix-flatpak,
      nix-vscode-extensions,
      ...
    }:
    let
      system = "x86_64-linux";
      username = "artur";
      pkgs = import nixpkgs { inherit system; };
    in
    {
      nixosConfigurations = {
        vm-ty = nixpkgs.lib.nixosSystem {
          inherit system;
          specialArgs = {
            inherit inputs;
          };
          modules = [
            ./configuration.nix
            inputs.disko.nixosModules.disko

            # make home-manager as a module of nixos
            # so that home-manager configuration will be deployed automatically when executing `nixos-rebuild switch`
            home-manager.nixosModules.home-manager
            {
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;

              home-manager.users."${username}" = import ./home.nix;

              # Optionally, use home-manager.extraSpecialArgs to pass arguments to home.nix
              home-manager.extraSpecialArgs = {
                inherit inputs;
              };
            }
          ];
        };
      };
      homeConfigurations."ty" = home-manager.lib.homeManagerConfiguration {
        inherit pkgs;
        modules = [
          ./hosts/ty/home.nix
          nix-flatpak.homeManagerModules.nix-flatpak
          {
            nixpkgs.overlays = [
              nix-vscode-extensions.overlays.default
            ];
          }
        ];
      };
    };
}
