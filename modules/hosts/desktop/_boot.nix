{ pkgs, ... }:
{
  boot = {
    kernelPackages = pkgs.linuxPackages_latest;
    kernelModules = [ "ntsync" ];
    loader = {
      efi.canTouchEfiVariables = true;
      systemd-boot = {
        enable = true;
        windows."win11" = {
          title = "Windows 11";
          efiDeviceHandle = "FS1";
        };
      };
    };
  };
}
