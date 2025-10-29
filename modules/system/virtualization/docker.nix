{ lib, ... }:
{
  virtualisation.docker = {
    # Disable system-wide docker
    enable = false;
    autoPrune = {
      enable = true;
      dates = "13:00";
    };
    storageDriver = lib.mkDefault "btrfs";
    rootless = {
      enable = true;
      setSocketVariable = true;
    };
  };
}
