{
  flake.modules.nixos.qemuguest = {
    services = {
      qemuGuest = {
        enable = true;
      };
    };
  };
}
