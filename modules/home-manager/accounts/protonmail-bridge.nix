{
  flake.modules.homeManager.email-personal = { pkgs, ... }: {
    services = {
      protonmail-bridge = {
        enable = true;
        logLevel = "warn";
      };
    };
    home = {
      packages = with pkgs; [ protonmail-bridge ];
    };
  };
}
