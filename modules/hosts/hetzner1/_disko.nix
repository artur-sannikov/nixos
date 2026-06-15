{
  disko.devices = {
    disk = {
      main = {
        device = "/dev/sda";
        type = "disk";
        content = {
          type = "gpt";
          partitions = {
            # Cost-optimized VM on Hetzner uses legacy BIOS
            # because it runs on older hardware
            boot = {
              size = "1M";
              type = "EF02"; # for grub MBR
              attributes = [ 0 ]; # partition attribute
            };
            root = {
              size = "100%";
              content = {
                type = "filesystem";
                format = "ext4";
                mountpoint = "/";
              };
            };
          };
        };
      };
    };
  };
}
