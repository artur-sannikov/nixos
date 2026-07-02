{
  flake.modules.nixos.gaming-packages =
    { pkgs, ... }:
    {
      environment = {
        systemPackages = with pkgs; [
          (heroic.override {
            extraPkgs = pkgs: [
              gamescope
              gamemode
              gamescope-wsi
            ];
          })
        ];
      };
    };
}
