{
  fileSystems = {
    "/mnt/nas/backup" = {
      device = "192.168.20.5:/mnt/tank/personal/backups/ty";
      fsType = "nfs";
      options = [
        "x-systemd.automount"
        "nofail"
        "noauto"
        "_netdev"
      ];
    };
    "/mnt/my-passport-newton" = {
      device = "/dev/disk/by-uuid/eb48c10f-643b-4c05-8b40-2341664535c2";
      fsType = "btrfs";
      options = [
        "nofail"
        "noauto"
        "_netdev"
        "user"
      ];
    };

  };
}
