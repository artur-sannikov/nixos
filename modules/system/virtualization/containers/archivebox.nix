{
  # Mount NFS
  config = {
    fileSystems = {
      "/mnt/nas/archivebox" = {
        device = "192.168.20.5:/mnt/tank/personal/archivebox";
        fsType = "nfs";
        options = [
          "x-systemd.automount"
          "nofail"
          "noauto"
          "_netdev"
        ];
      };
    };
  };
}
