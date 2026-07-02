{ inputs, ... }:
{
  flake.modules.nixos.zfs = {
    imports = with inputs.self.modules.nixos; [
      sanoid
      syncoid
    ];
  };
}
