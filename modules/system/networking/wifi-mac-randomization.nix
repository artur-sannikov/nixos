{
  flake.modules.nixosModules.base = {
    config = {
      networking = {
        networkmanager = {
          wifi = {
            macAddress = "random";
            powersave = true;
          };
          settings = {
            connection = {
              "wifi.cloned-mac-address" = "random";
            };
          };
        };
      };
    };
  };
}
