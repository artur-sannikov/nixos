{
  description = "NixOS configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    nixpkgs-stable.url = "github:nixos/nixpkgs/nixos-25.11";
    disko.url = "github:nix-community/disko";
    disko.inputs.nixpkgs.follows = "nixpkgs";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # Firefox extensions
    firefox-extensions = {
      url = "gitlab:rycee/nur-expressions?dir=pkgs/firefox-addons";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # https://github.com/danth/stylix
    stylix = {
      url = "github:nix-community/stylix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nixvim = {
      url = "github:nix-community/nixvim";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    lanzaboote = {
      url = "github:nix-community/lanzaboote/v1.0.0";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    # Remap keyboard keys
    xremap-flake = {
      url = "github:xremap/nix-flake";
    };
    colmena.url = "github:zhaofengli/colmena";

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
      nixvim,
      lanzaboote,
      colmena,
    self,
      ...
    }:
    let
      system = "x86_64-linux";
      username = "artur";
conf = self.nixosConfigurations;

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
  colmena = {
    meta = {
      description = "my personal machines";
      # This can be overriden by node nixpkgs
      nixpkgs = import inputs.nixpkgs { system = "x86_64-linux"; };
      nodeNixpkgs = builtins.mapAttrs (name: value: value.pkgs) conf;
      nodeSpecialArgs = builtins.mapAttrs (name: value: value._module.specialArgs) conf;
    };
  } // builtins.mapAttrs (name: value: { imports = value._module.args.modules; }) conf;
        #   # nixpkgs = import nixpkgs { system = "x86_64-linux"; };
        #
        #   # This parameter functions similarly to `specialArgs` in `nixosConfigurations.xxx`,
        #   # used for passing custom arguments to all submodules.
        #   # specialArgs = {
        #   #   inherit nixpkgs;
        #   # };
        # };

        # Host name = "my-nixos"
        "hetnzer1" =
          { name, nodes, ... }:
          {
            # Parameters related to remote deployment
            deployment.targetHost = "hetnzer1"; # Remote host's IP address
            deployment.targetUser = "artur"; # Remote host's username

            # This parameter functions similarly to `modules` in `nixosConfigurations.xxx`,
            # used for importing all submodules.
            imports = [
              ./hosts/hetzner1/configuration.nix
            ];
          };
      };
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
            inputs.xremap-flake.nixosModules.default
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
    };
}
