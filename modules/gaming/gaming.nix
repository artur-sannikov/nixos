{ config, ... }:
{
  flake.modules.nixos.gaming = {
    imports = with config.flake.modules.nixos; [
      gaming-packages
      steam
    ];
  };
}
