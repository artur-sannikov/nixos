{
  # Mount NFS
  fileSystems = {
    "/mnt/nas/photos" = {
      device = "192.168.20.5:/mnt/tank/personal/photos";
      fsType = "nfs";
      options = [
        "x-systemd.automount"
        "nofail"
        "noauto"
        "_netdev"
      ];
    };
  };

  users = {
    users = {
      immich = {
        isSystemUser = true;
        group = "immich";
      };
    };
    groups = {
      immich = {
        gid = 1002;
      };
    };
  };

  services = {
    immich = {
      enable = true;
      user = "immich";
      group = "immich";
      openFirewall = true;
      host = "0.0.0.0";
      mediaLocation = "/mnt/nas/photos";
    };
  };
}
