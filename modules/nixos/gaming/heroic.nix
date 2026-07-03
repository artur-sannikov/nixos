{
  flake.modules.nixos.gaming-packages =
    { pkgs, ... }:
    {
      environment = {
        systemPackages = [
          (pkgs.heroic.override {
            extraPkgs = pkgs: [
              pkgs.gamescope
              pkgs.gamemode
              pkgs.gamescope-wsi
            ];
          })
        ];
      };
    };
}
