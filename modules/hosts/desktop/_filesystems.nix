{
  fileSystems = {
    "/mnt/nas/media" = {
      device = "192.168.20.5:/mnt/tank/media";
      fsType = "nfs";
      options = [
        "x-systemd.automount"
        "nofail"
        "noauto"
        "_netdev"
      ];
    };
    "/mnt/nas/backup" = {
      device = "192.168.20.5:/mnt/tank/personal/backups/desktop";
      fsType = "nfs";
      options = [
        "x-systemd.automount"
        "nofail"
        "noauto"
        "_netdev"
      ];
    };
  };
}
