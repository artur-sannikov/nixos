{
  flake.modules.nixos.nvme-rs = {
    services = {
      nvme-rs = {
        enable = true;
      };
    };
  };
}
