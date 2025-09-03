{
  config,
  ...
}:
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
    commonArgs = [
      "--no-sync-snap"
      "--debug"
    ];
    commands = {
      "home" = {
        source = "zroot/home";
        target = "syncoid@192.168.20.5:tank/personal/backups/asus";
        extraArgs = [
          "--exclude=Downloads"
          "--exclude=zfs_exclude"
          "--delete-target-snapshots" # Delete snapshots on target which are missing on source
          "--sshoption=StrictHostKeyChecking=off"
        ];
        recursive = false;
        sendOptions = "w"; # raw
        recvOptions = "u"; # umount
      };
    };
  };
}
