{ lib, ... }:
{
  virtualisation.docker = {
    # Disable system-wide docker
    enable = false;
    storageDriver = lib.mkDefault "btrfs";
    rootless = {
      enable = true;
      setSocketVariable = true;
    };
  };
}
