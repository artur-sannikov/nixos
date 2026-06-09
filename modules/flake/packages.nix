{
  flake.overlays.default = final: {
    duplicacy-web = final.callPackage ../home-manager/gui/duplicacy-web.nix { };
  };
}
