{
  description = "NixOS configuration";

  inputs = {
    nixpkgs = {
      url = "github:nixos/nixpkgs/nixos-unstable";
    };
    nixpkgs-stable = {
      url = "github:nixos/nixpkgs/nixos-25.11";
    };

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # Some hardware configurations
    # https://github.com/NixOS/nixos-hardware
    nixos-hardware = {
      url = "github:NixOS/nixos-hardware/master";
    };

    # Declarative disk configuration
    # https://github.com/nix-community/disko
    disko = {
      url = "github:nix-community/disko";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # Secrets management
    # https://github.com/Mic92/sops-nix
    sops-nix = {
      url = "github:mic92/sops-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nix-secrets = {
      url = "git+ssh://git@codeberg.org/arsann/nix-secrets.git?ref=main&shallow=1";
      inputs = { };
    };

    # Secure Boot
    # https://github.com/nix-community/lanzaboote
    lanzaboote = {
      url = "github:nix-community/lanzaboote/v1.0.0";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # Ricing
    # https://github.com/danth/stylix
    stylix = {
      url = "github:nix-community/stylix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # Nice editor
    # https://nix-community.github.io/nixvim/
    nixvim = {
      url = "github:nix-community/nixvim";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # Remap keyboard keys
    # https://github.com/xremap/nix-flake
    xremap-flake = {
      url = "github:xremap/nix-flake";
    };

    # Remote deployment
    deploy-rs = {
      url = "github:serokell/deploy-rs";
    };
  };

  outputs =
    inputs@{
      nixpkgs-stable,
      nixpkgs,
      disko,
      home-manager,
      stylix,
      nixvim,
      lanzaboote,
      deploy-rs,
      nixos-hardware,
      self,
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
        tuxedo = lib.nixosSystem {
          inherit system pkgs;
          specialArgs = {
            flake-inputs = inputs;
            inherit username;
            inherit pkgs-stable;
          };
          modules = [
            ./hosts/tuxedo/configuration.nix
            disko.nixosModules.disko
            home-manager.nixosModules.home-manager
            stylix.nixosModules.stylix
            lanzaboote.nixosModules.lanzaboote
            nixos-hardware.nixosModules.tuxedo-infinitybook-pro14-gen9-amd
            inputs.xremap-flake.nixosModules.default
            {
              home-manager = {
                useGlobalPkgs = true;
                useUserPackages = true;
                users."${username}".imports = [
                  nixvim.homeModules.nixvim
                  ./hosts/tuxedo/home.nix
                ];
                extraSpecialArgs = {
                  flake-inputs = inputs;
                  inherit pkgs-stable;
                  inherit username;
                };
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
            {
              home-manager = {
                useGlobalPkgs = true;
                useUserPackages = true;
                users."${username}".imports = [
                  nixvim.homeModules.nixvim
                  ./hosts/desktop/home.nix
                ];
                extraSpecialArgs = {
                  flake-inputs = inputs;
                  inherit pkgs-stable;
                  inherit username;
                };
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
            inputs.xremap-flake.nixosModules.default
            {
              home-manager = {
                useGlobalPkgs = true;
                useUserPackages = true;
                users."${username}".imports = [
                  nixvim.homeModules.nixvim
                  ./hosts/ty/home.nix
                ];
                extraSpecialArgs = {
                  flake-inputs = inputs;
                  inherit pkgs-stable;
                  inherit username;
                };
              };
            }
          ];
        };
        homelab-nixos = lib.nixosSystem {
          inherit system pkgs;
          specialArgs = {
            flake-inputs = inputs;
            inherit username;
            inherit pkgs-stable;
          };
          modules = [
            ./hosts/homelab-nixos/configuration.nix
            ./hosts/homelab-nixos/hardware-configuration.nix
            disko.nixosModules.disko
          ];
        };
        hetzner1 = lib.nixosSystem {
          inherit system pkgs;
          specialArgs = {
            flake-inputs = inputs;
            inherit username;
            inherit pkgs-stable;
          };
          modules = [
            ./hosts/hetzner1/configuration.nix
            ./hosts/hetzner1/hardware-configuration.nix
            disko.nixosModules.disko
          ];
        };
      };
      deploy.nodes = {
        hetzner1 = {
          hostname = "hetzner1";
          sshUser = "${username}";
          interactiveSudo = false;
          profiles.system = {
            user = "root";
            path = deploy-rs.lib.x86_64-linux.activate.nixos self.nixosConfigurations.hetzner1;
          };
        };
        homelab-nixos = {
          hostname = "homelab-nixos";
          sshUser = "${username}";
          interactiveSudo = false;
          profiles.system = {
            user = "root";
            path = deploy-rs.lib.x86_64-linux.activate.nixos self.nixosConfigurations.homelab-nixos;
          };
        };
      };
      checks = builtins.mapAttrs (system: deployLib: deployLib.deployChecks self.deploy) deploy-rs.lib;
    };
}
