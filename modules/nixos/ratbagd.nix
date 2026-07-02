{
  flake.modules.nixos.ratbagd =
    { pkgs, ... }:
    {
      services.ratbagd.enable = true;
      environment.systemPackages = [
        pkgs.piper
      ];
    };
}
