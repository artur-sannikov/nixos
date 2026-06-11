{ inputs, ... }:
{
  flake.modules.nixosModules.zfs = {
    imports = with inputs.self.modules.nixosModules; [
      sanoid
      syncoid
    ];
  };
}
