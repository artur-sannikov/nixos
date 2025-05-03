{
  description = "NixOS configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    nixpkgs-stable.url = "github:nixos/nixpkgs/nixos-24.11";
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
    stylix = {
      url = "github:danth/stylix/release-24.11";
    };

    # Catppuccin theme
    # https://github.com/catppuccin/nix
    catppuccin.url = "github:catppuccin/nix";

    # Catppuccin theme for VSCodium
    # https://github.com/catppuccin/vscode
    #catppuccin-vsc.url = "https://flakehub.com/f/catppuccin/vscode/*.tar.gz";

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

    # flox = {
    #   url = "github:flox/flox";
    #   inputs.nixpkgs.follows = "nixpkgs";
    # };

    # Motherboard support in latest experimental
    # Update to stable release later
    openrgb-experimental = {
      url = "gitlab:CalcProgrammer1/OpenRGB";
      flake = false;
    };

    sops-nix = {
      url = "github:mic92/sops-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nix-secrets = {
      url = "git+ssh://git@codeberg.org/arsann/nix-secrets.git?ref=main&shallow=1";
      inputs = {};
    };
  };

  outputs =
    inputs@{
      nixpkgs-stable,
      nixpkgs,
      disko,
      home-manager,
      stylix,
      catppuccin,
      # catppuccin-vsc,
      flatpaks,
      nixvim,
      lanzaboote,
      ...
    }:
    let
      system = "x86_64-linux";
      username = "artur";

      # ========== Extend lib with lib.custom ==========
      lib = nixpkgs.lib.extend (self: super: { custom = import ./lib { inherit (nixpkgs) lib; }; });

      # overlays = [
      #   catppuccin-vsc.overlays.default
      # ];
      pkgs = import nixpkgs {
        inherit system;
        config.allowUnfreePredicate =
          pkg:
          builtins.elem (nixpkgs.lib.getName pkg) [
            "duplicacy-web"
            "obsidian"
            "terraform"
            "slack"
            "steam"
            "steam-unwrapped"
            "veracrypt"
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
            # make home-manager as a module of nixos
            # so that home-manager configuration will be deployed automatically when executing `nixos-rebuild switch`
            home-manager.nixosModules.home-manager
            stylix.nixosModules.stylix
            lanzaboote.nixosModules.lanzaboote
            {
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;
              home-manager.users."${username}".imports = [
                nixvim.homeManagerModules.nixvim
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
        test-vm = lib.nixosSystem {
          inherit system;
          specialArgs = {
            flake-inputs = inputs;
            inherit pkgs;
            inherit username;
            inherit pkgs-stable;
          };
          modules = [
            ./hosts/test-vm/configuration.nix
            disko.nixosModules.disko
            home-manager.nixosModules.home-manager
            {
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;
              home-manager.users."${username}".imports = [
                nixvim.homeManagerModules.nixvim
                ./hosts/test-vm/home.nix
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
            # make home-manager as a module of nixos
            # so that home-manager configuration will be deployed automatically when executing `nixos-rebuild switch`
            home-manager.nixosModules.home-manager
            stylix.nixosModules.stylix
            catppuccin.nixosModules.catppuccin
            {
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;
              home-manager.users."${username}".imports = [
                nixvim.homeManagerModules.nixvim
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
      homeConfigurations."ty" = home-manager.lib.homeManagerConfiguration {
        inherit pkgs;
        extraSpecialArgs = {
          flake-inputs = inputs;
          inherit username;
          inherit pkgs-stable;
          # inherit overlays;
        };
        modules = [
          ./hosts/ty/home.nix
          catppuccin.homeModules.catppuccin
          stylix.homeManagerModules.stylix
          nixvim.homeManagerModules.nixvim
        ];
      };
    };
}
