{
  fileSystems = {
    "/mnt/nas/backups/forgejo-dump" = {
      device = "192.168.20.5:/mnt/tank/personal/backups/forgejo-dump";
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
