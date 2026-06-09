{ inputs, ... }:
{
  flake.modules.nixos.base.imports = [ inputs.xremap-flake.nixosModules.default ];
}
