# {
#   perSystem = { pkgs, ... }: {
#     packages.duplicacy-web = pkgs.callPackage ./duplicacy-web/_package.nix { };
#   };
#
#   flake.overlays.duplicacy-web = final: _: {
#     duplicacy-web = final.callPackage ./duplicacy-web/_package.nix { };
#   };
# }

{ config, lib, ... }: {
  options.packages = lib.mkOption {
    type = lib.types.attrsOf (lib.types.functionTo lib.types.package);
    default = { };
  };

  config = {
    perSystem = { pkgs, ... }: {
      packages = builtins.intersectAttrs config.packages pkgs;
    };
    flake.overlays.additions =
      final: _prev: builtins.mapAttrs (_: pkg: final.callPackage pkg { }) config.packages;
  };
}
