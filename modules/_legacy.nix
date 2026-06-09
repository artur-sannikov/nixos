{ inputs, ... }:
let
  inherit (inputs)
    deploy-rs
    nixpkgs
    nixpkgs-stable
    disko
    home-manager
    lanzaboote
    nixos-hardware
    stylix
    self
    ;
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
  flake.nixosConfigurations = {
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
        (import ./overlay.nix)
        {
          home-manager = {
            useGlobalPkgs = true;
            useUserPackages = true;
            users."${username}".imports = [
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
        ../hosts/desktop/configuration.nix
        disko.nixosModules.disko
        home-manager.nixosModules.home-manager
        lanzaboote.nixosModules.lanzaboote
        stylix.nixosModules.stylix
        (import ./overlay.nix)
        {
          home-manager = {
            useGlobalPkgs = true;
            useUserPackages = true;
            users."${username}".imports = [
              ../hosts/desktop/home.nix
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
        (import ./overlay.nix)
        {
          home-manager = {
            useGlobalPkgs = true;
            useUserPackages = true;
            users."${username}".imports = [
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
  flake.deploy = {
    nodes = {
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
  };
  perSystem = { system, ... }: {
    checks = deploy-rs.lib.${system}.deployChecks self.deploy;
  };
}
