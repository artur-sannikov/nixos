{
  services.sanoid = {
    enable = true;
    extraArgs = [
      "--verbose"
    ];
    interval = "hourly";
    templates = {
      "backup" = {
        "hourly" = 36;
        "daily" = 30;
        "monthly" = 3;
        "yearly" = 0;
        "autosnap" = true;
        "autoprune" = true;
      };
      "none" = {
        "autosnap" = false;
        "autoprune" = false;
      };
    };
    datasets = {
      "zroot/home" = {
        useTemplate = [ "backup" ];
      };
      "zroot/home/Downloads" = {
        useTemplate = [ "none" ];
      };
      "zroot/home/zfs_exclude" = {
        useTemplate = [ "none" ];
      };
    };
  };
}
