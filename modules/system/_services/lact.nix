{
  flake.modules.nixosModules.lact = {
    services = {
      lact = {
        enable = true;
      };
    };
  };
}
