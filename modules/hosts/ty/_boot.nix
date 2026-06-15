{
  boot = {
    loader = {
      systemd-boot = {
        enable = true;
        windows = {
          "win10" = {
            title = "Windows 10";
            efiDeviceHandle = "HD1b";
          };
        };
      };
    };
  };
}
