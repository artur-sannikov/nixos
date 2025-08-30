{
  description = "NixOS configuration";

  inputs = {
    # workaroun for stylix
    nixpkgs.url = "github:nixos/nixpkgs/20075955deac2583bb12f07151c2df830ef346b4";
    nixpkgs-stable.url = "github:nixos/nixpkgs/nixos-25.05";
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

    # https://github.com/danth/stylix
    # See workaround for missing kde6 qt.platformTheme option https://github.com/nix-community/stylix/issues/1865
    stylix = {
      url = "github:nix-community/stylix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nixvim = {
      url = "github:nix-community/nixvim";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    umu = {
      url = "github:Open-Wine-Components/umu-launcher?dir=packaging/nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    lanzaboote = {
      url = "github:nix-community/lanzaboote/v0.4.2";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # solaar = {
    #   url = "https://flakehub.com/f/Svenum/Solaar-Flake/*.tar.gz"; # For latest stable version
    #   inputs.nixpkgs.follows = "nixpkgs";
    # };

    # flox = {
    #   url = "github:flox/flox";
    #   inputs.nixpkgs.follows = "nixpkgs";
    # };

    # Motherboard support in latest experimental
    # Update to stable release later
    openrgb-experimental = {
      url = "gitlab:CalcProgrammer1/OpenRGB?rev=12a3b1f83e5e59ab508a032a674ff039db1b802c";
      flake = false;
    };

    sops-nix = {
      url = "github:mic92/sops-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nix-secrets = {
      url = "git+ssh://git@codeberg.org/arsann/nix-secrets.git?ref=main&shallow=1";
      inputs = { };
    };
  };

  outputs =
    inputs@{
      nixpkgs-stable,
      nixpkgs,
      disko,
      home-manager,
      stylix,
      flatpaks,
      nixvim,
      lanzaboote,
      # solaar,
      ...
    }:
    let
      system = "x86_64-linux";
      username = "artur";

      # ========== Extend lib with lib.custom ==========
      lib = nixpkgs.lib.extend (self: super: { custom = import ./lib { inherit (nixpkgs) lib; }; });

      pkgs = import nixpkgs {
        inherit system;
        config.allowUnfreePredicate =
          pkg:
          builtins.elem (nixpkgs.lib.getName pkg) [
            "castlabs-electron"
            "duplicacy-web"
            "obsidian"
            "terraform"
            "slack"
            "steam"
            "steam-unwrapped"
            "veracrypt"
            "via"
            "zoom"
          ];
      };
      pkgs-stable = import nixpkgs-stable {
        inherit system;
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
            inherit pkgs;
            inherit username;
            inherit pkgs-stable;
          };
          modules = [
            ./hosts/asus-laptop/configuration.nix
            disko.nixosModules.disko
            flatpaks.nixosModules.nix-flatpak
            home-manager.nixosModules.home-manager
            stylix.nixosModules.stylix
            lanzaboote.nixosModules.lanzaboote
            {
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;
              home-manager.users."${username}".imports = [
                nixvim.homeModules.nixvim
                ./hosts/asus-laptop/home.nix
              ];
              home-manager.extraSpecialArgs = {
                flake-inputs = inputs;
                inherit pkgs-stable;
                inherit username;
              };
            }
          ];
        };
        desktop = lib.nixosSystem {
          inherit system pkgs;
          specialArgs = {
            flake-inputs = inputs;
            inherit username;
            inherit pkgs-stable;
          };
          modules = [
            ./hosts/desktop/configuration.nix
            disko.nixosModules.disko
            home-manager.nixosModules.home-manager
            lanzaboote.nixosModules.lanzaboote
            stylix.nixosModules.stylix
            # solaar.nixosModules.default
            {
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;
              home-manager.users."${username}".imports = [
                nixvim.homeModules.nixvim
                ./hosts/desktop/home.nix
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
        ty = lib.nixosSystem {
          inherit system pkgs;
          specialArgs = {
            flake-inputs = inputs;
            inherit username;
            inherit pkgs-stable;
          };
          modules = [
            ./hosts/ty/configuration.nix
            home-manager.nixosModules.home-manager
            stylix.nixosModules.stylix
            lanzaboote.nixosModules.lanzaboote

            {
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;
              home-manager.users."${username}".imports = [
                nixvim.homeModules.nixvim
                ./hosts/ty/home.nix
              ];

              home-manager.extraSpecialArgs = {
                flake-inputs = inputs;
                inherit pkgs-stable;
                inherit username;
              };
            }
          ];
        };
        homelab-services = lib.nixosSystem {
          inherit system pkgs;
          specialArgs = {
            flake-inputs = inputs;
            inherit username;
            inherit pkgs-stable;
          };
          modules = [
            ./hosts/homelab-services/configuration.nix
            ./hosts/homelab-services/hardware-configuration.nix
            disko.nixosModules.disko
          ];
        };
      };
    };
}
