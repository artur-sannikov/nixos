{ config, ... }:
{
  # Secrets
  sops = {
    secrets = {
      "keys/ssh/syncoid-ssh-key" = {
        owner = "syncoid";
        mode = "600";
      };
    };
  };
  services.syncoid = {
    enable = true;
    sshKey = config.sops.secrets."keys/ssh/syncoid-ssh-key".path;
    commands = {
      "zroot/home" = {
        target = "syncoid@192.168.20.5:tank/personal/backups/asus";
        extraArgs = [
          "--exclude=Downloads"
          "--exclude=zfs_exclude"
        ];
        recursive = true;
      };
    };
  };
}
