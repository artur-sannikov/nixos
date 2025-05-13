{
  services.sanoid = {
    enable = true;
    extraArgs = [
      "--verbose"
    ];
    interval = "hourly";
    templates = {
      "backups" = {
        "hourly" = 24;
        "daily" = 7;
        "monthly" = 2;
        "yearly" = 0;
        "autosnap" = true;
        "autoprune" = true;
      };
    };
    datasets = {
      "home/Documents" = {
        useTemplate = [ "backups" ];
      };
      "home/Desktop" = {
        useTemplate = [ "backups" ];
      };
    };
  };
}
