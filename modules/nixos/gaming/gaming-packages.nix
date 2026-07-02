{
  flake.modules.nixos.gaming-packages =
    { pkgs, ... }:
    {
      environment = {
        systemPackages = with pkgs; [
          mangohud
          protonup-ng
          protonup-qt
          protontricks
          umu-launcher
        ];
      };
    };
}
