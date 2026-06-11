{
  flake.modules.nixosModules.base = {
    services.earlyoom = {
      enable = true;
    };
  };
}
