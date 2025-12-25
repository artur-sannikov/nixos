{
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
        };
      };
    };
  };
}
