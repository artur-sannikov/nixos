{ inputs, ... }:
{
  flake.modules.nixosModules.gaming = {
    imports = with inputs.self.modules.nixosModules; [
      lact
      openrgb
      steam
    ];
  };
}
