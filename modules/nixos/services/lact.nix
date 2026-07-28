{
  flake.modules.nixos.lact =
    { pkgs, ... }:
    {
      services = {
        lact = {
          package = pkgs.stable.lact;
          enable = true;
        };
      };
    };
}
