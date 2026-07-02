{
  flake.modules.nixos.wifi-privacy = {
    config = {
      networking = {
        networkmanager = {
          wifi = {
            macAddress = "random";
          };
          settings = {
            connection = {
              "wifi.cloned-mac-address" = "random";
            };
            device = {
              "wifi.scan-rand-mac-address" = true;
            };
          };
        };
      };
    };
  };
}
