{
  flake.modules = {
    nixos.udiskie = {
      services = {
        udisks2 = {
          enable = true;
        };
      };
    };
    homeManager.udiskie =
      { pkgs, ... }:
      {
        services.udiskie = {
          enable = true;
          settings = {
            program_options = {
              file_manager = "${pkgs.kdePackages.dolphin}/bin/dolphin";
            };
          };
        };
      };
  };
}
