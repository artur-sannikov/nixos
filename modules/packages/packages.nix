{
  perSystem = { pkgs, ... }: {
    packages.duplicacy-web = pkgs.callPackage ./duplicacy-web/_package.nix { };
  };

  flake.overlays.duplicacy-web = final: _: {
    duplicacy-web = final.callPackage ./duplicacy-web/_package.nix { };
  };
}
