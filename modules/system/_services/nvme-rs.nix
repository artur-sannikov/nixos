{
  flake.modules.nixosModules.nvme = {
    services = {
      nvme-rs = {
        enable = true;
      };
    };
  };
}
