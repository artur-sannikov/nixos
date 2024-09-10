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
    flatpaks.url = "github:gmodena/nix-flatpak";

    # VS Code extensions
    nix-vscode-extensions = {
      url = "github:nix-community/nix-vscode-extensions";
      inputs.nixpkgs.follows = "nixpkgs-unstable";
    };

    # Firefox extensions
    firefox-extensions = {
      url = "gitlab:rycee/nur-expressions?dir=pkgs/firefox-addons";
      inputs.nixpkgs.follows = "nixpkgs-unstable";
    };

    # Shadow PC on NixOS
    shadow-nix = {
      url = "github:tsandrini/shadow-nix";
      flake = false;
    };

    # Generate Podman Quadlet files
    podlet.url = "github:artur-sannikov/podlet/devel";
  };

  outputs =
    inputs@{
      nixpkgs-unstable,
      nixpkgs-stable,
      home-manager,
      nix-vscode-extensions,
      flatpaks,
      ...
    }:
    let
      system = "x86_64-linux";
      username = "artur";
      lib = nixpkgs-stable.lib;
      pkgs-unstable = import nixpkgs-unstable {
        inherit system;
        config.allowUnfree = true;
      };
      pkgs = import nixpkgs-stable {
        inherit system;
        config = {
          allowUnfree = true;
        };
      };
    in
    {
      nixosConfigurations = {
        vm-ty = lib.nixosSystem {
          inherit system;
          specialArgs = {
            inherit username;
            inherit pkgs;
            inherit pkgs-unstable;
          };
          modules = [
            ./hosts/vm-ty/configuration.nix
            inputs.disko.nixosModules.disko
            inputs.flatpaks.nixosModules.nix-flatpak
            # make home-manager as a module of nixos
            # so that home-manager configuration will be deployed automatically when executing `nixos-rebuild switch`
            home-manager.nixosModules.home-manager
            {
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;
              home-manager.users."${username}".imports = [
                ./hosts/vm-ty/home.nix
              ];

              # Optionally, use home-manager.extraSpecialArgs to pass arguments to home.nix
              home-manager.extraSpecialArgs = {
                flake-inputs = inputs;
                inherit pkgs-unstable;
              };
            }
          ];
        };
        asus-laptop = lib.nixosSystem {
          inherit system;
          specialArgs = {
            flake-inputs = inputs;
            inherit username;
            inherit pkgs;
            inherit pkgs-unstable;
          };
          modules = [
            ./hosts/asus-laptop/configuration.nix
            inputs.disko.nixosModules.disko
            inputs.flatpaks.nixosModules.nix-flatpak
            # make home-manager as a module of nixos
            # so that home-manager configuration will be deployed automatically when executing `nixos-rebuild switch`
            home-manager.nixosModules.home-manager
            {
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;
              home-manager.users."${username}".imports = [
                ./hosts/asus-laptop/home.nix
              ];

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
          flake-inputs = inputs;
          inherit username;
          inherit pkgs-unstable;
        };
        modules = [
          ./hosts/ty/home.nix
          {
            nixpkgs.overlays = [
              nix-vscode-extensions.overlays.default
            ];
          }
        ];
      };
    };
}
