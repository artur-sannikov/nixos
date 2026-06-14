{ inputs, ... }: {
  flake.modules.nixos.home-manager = { config, ... }: {
    imports = [
      inputs.home-manager.nixosModules.home-manager
    ];

    home-manager = {
      useGlobalPkgs = true;
      useUserPackages = true;
      extraSpecialArgs = {
        inherit inputs;
        username = "artur";
        inherit (config._module.args) pkgs-stable;
      };
      users = {
        artur = {
          home = {
            stateVersion = "24.05";
          };
        };
      };
    };
  };
}
