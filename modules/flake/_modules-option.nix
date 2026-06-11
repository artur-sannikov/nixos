{ lib, ... }:
{
  options.flake.modules = lib.mkOption {
    type = with lib.types; lazyAttrsOf (lazyAttrsOf deferredModule);
    default = { };
    description = "NixOS/home-manager modules merged across the tree.";
  };
}
