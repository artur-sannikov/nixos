{ username, ... }:
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
      device = "/dev/disk/by-uuid/c98b96a0-c640-4c02-8a36-90b36d8425f0";
      fsType = "ext4";
      options = [
        "nofail"
        "noauto"
        "user"
      ];
    };
  };

  systemd.tmpfiles.rules = [
    "d /mnt/my-passport-newton 0775 ${username} users -"
  ];
}
