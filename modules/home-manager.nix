{ inputs, ... }: {
  flake.modules.nixos.home-manager = {
    imports = [
      inputs.home-manager.nixosModules.home-manager
    ];

    home-manager = {
      useGlobalPkgs = true;
      useUserPackages = false;
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
