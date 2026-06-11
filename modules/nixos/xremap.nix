{ inputs, ... }:
{
  flake.modules.nixosModules.xremap.imports = [ inputs.xremap-flake.nixosModules.default ];
}
