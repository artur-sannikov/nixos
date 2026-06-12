{ inputs, config, ... }:
{
  # flake.modules.nixosModules.gaming = {
  flake.modules.nixosModules.gaming = {
    imports = with config.flake.modules.nixosModules; [
      lact
      ratbagd
      openrgb
      steam
    ];
  };
}
