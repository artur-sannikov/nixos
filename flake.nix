{
  description = "NixOS configuration";

  inputs = {
    nixpkgs = {
      url = "github:nixos/nixpkgs/nixos-unstable";
    };
    nixpkgs-stable = {
      url = "github:nixos/nixpkgs/nixos-26.05";
    };
    nixpkgs-master = {
      url = "github:NixOS/nixpkgs/master";
    };

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    plasma-manager = {
      url = "github:nix-community/plasma-manager";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.home-manager.follows = "home-manager";
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
      url = "github:nix-community/lanzaboote/v1.1.0";
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
    nixvim.url = "github:nix-community/nixvim";

    # Remap keyboard keys
    # https://github.com/xremap/nix-flake
    xremap-flake = {
      url = "github:xremap/nix-flake";
    };

    # https://github.com/fufexan/nix-gaming
    nix-gaming = {
      url = "github:fufexan/nix-gaming";
    };

    # Remote deployment
    deploy-rs = {
      url = "github:serokell/deploy-rs";
    };

    flake-parts = {
      url = "github:hercules-ci/flake-parts";
    };

    import-tree = {
      url = "github:vic/import-tree";
    };

    niri = {
      # url = "github:sodiboo/niri-flake";
      url = "github:epireyn/niri-flake";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nur = {
      url = "github:nix-community/NUR";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    dms = {
      url = "github:AvengeMedia/DankMaterialShell/stable";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nixpkgs-podman.url = "github:NixOS/nixpkgs/b153953686370a8dc14231db115b058b137644de";
  };

  outputs = inputs: inputs.flake-parts.lib.mkFlake { inherit inputs; } (inputs.import-tree ./modules);
}
