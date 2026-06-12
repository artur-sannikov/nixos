{
  flake.modules.nixos.base = {
    services.earlyoom = {
      enable = true;
    };
  };
}
