{
  description = "NixOS configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    nixpkgs-stable.url = "github:nixos/nixpkgs/nixos-24.05";
    disko.url = "github:nix-community/disko";
    disko.inputs.nixpkgs.follows = "nixpkgs";
    # home-manager, used for managing user configuration
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    # Declarative Nix Flatpaks
    flatpaks.url = "github:gmodena/nix-flatpak";

    # VS Code extensions
    nix-vscode-extensions = {
      url = "github:nix-community/nix-vscode-extensions";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # Firefox extensions
    firefox-extensions = {
      url = "gitlab:rycee/nur-expressions?dir=pkgs/firefox-addons";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # Generate Podman Quadlet files
    podlet.url = "github:artur-sannikov/podlet/devel";

    # https://github.com/danth/stylix
    stylix = {
      url = "github:danth/stylix/cf8b6e2d4e8aca8ef14b839a906ab5eb98b08561";
    };

    # Catppuccin theme
    # https://github.com/catppuccin/nix
    catppuccin.url = "github:catppuccin/nix";

    # Catppuccin theme for VSCodium
    # https://github.com/catppuccin/vscode
    catppuccin-vsc.url = "https://flakehub.com/f/catppuccin/vscode/*.tar.gz";
  };

  outputs =
    inputs@{
      nixpkgs-stable,
      nixpkgs,
      disko,
      home-manager,
      stylix,
      catppuccin,
      catppuccin-vsc,
      flatpaks,
      ...
    }:
    let
      system = "x86_64-linux";
      username = "artur";
      lib = nixpkgs.lib;
      overlays = [
        catppuccin-vsc.overlays.default
      ];
      pkgs = import nixpkgs {
        inherit system overlays;
        config.allowUnfree = true;
      };
      pkgs-stable = import nixpkgs-stable {
        inherit system overlays;
        config = {
          allowUnfree = true;
        };
      };
    in
    {
      nixosConfigurations = {
        asus-laptop = lib.nixosSystem {
          inherit system;
          specialArgs = {
            flake-inputs = inputs;
            inherit username;
            inherit pkgs;
            inherit pkgs-stable;
          };
          modules = [
            ./hosts/asus-laptop/configuration.nix
            disko.nixosModules.disko
            flatpaks.nixosModules.nix-flatpak
            # make home-manager as a module of nixos
            # so that home-manager configuration will be deployed automatically when executing `nixos-rebuild switch`
            home-manager.nixosModules.home-manager
            stylix.nixosModules.stylix
            {
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;
              home-manager.users."${username}".imports = [
                ./hosts/asus-laptop/home.nix
              ];

              # Optionally, use home-manager.extraSpecialArgs to pass arguments to home.nix
              home-manager.extraSpecialArgs = {
                flake-inputs = inputs;
                inherit pkgs-stable;
                inherit username;
              };
            }
          ];
        };
                desktop = lib.nixosSystem {
          inherit system;
          specialArgs = {
            flake-inputs = inputs;
            inherit username;
            inherit pkgs;
            inherit pkgs-stable;
          };
          modules = [
            ./hosts/desktop/configuration.nix
            disko.nixosModules.disko
            # make home-manager as a module of nixos
            # so that home-manager configuration will be deployed automatically when executing `nixos-rebuild switch`
            home-manager.nixosModules.home-manager
            stylix.nixosModules.stylix
            {
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;
              home-manager.users."${username}".imports = [
                ./hosts/asus-laptop/home.nix
              ];

              # Optionally, use home-manager.extraSpecialArgs to pass arguments to home.nix
              home-manager.extraSpecialArgs = {
                flake-inputs = inputs;
                inherit pkgs-stable;
                inherit username;
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
          inherit pkgs-stable;
          inherit overlays;
        };
        modules = [
          ./hosts/ty/home.nix
          catppuccin.homeManagerModules.catppuccin
          stylix.homeManagerModules.stylix
        ];
      };
    };
}
