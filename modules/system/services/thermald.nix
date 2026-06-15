{
  flake.modules.nixos.thermald = {
    services = {
      # Prevent Intel CPU overheating
      thermald = {
        enable = true;
      };
    };
  };
}
