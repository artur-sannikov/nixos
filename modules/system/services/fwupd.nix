{
  flake.modules.nixosModules.fwupd = {
    services = {
      fwupd = {
        enable = true;
      };
    };
  };
}
