{
  flake.modules.nixosModules.ratbagd =
    { pkgs, ... }:
    {
      services.ratbagd.enable = true;
      environment.systemPackages = [
        pkgs.piper
      ];
    };
}
