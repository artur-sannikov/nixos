{ inputs, ... }:
{
  flake.modules.nixos.zfs = {
    imports = with inputs.self.modules.nixosModules; [
      sanoid
      syncoid
    ];
  };
}
