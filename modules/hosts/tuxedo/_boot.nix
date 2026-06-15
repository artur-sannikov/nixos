{ config, ... }:
{
  boot = {
    extraModulePackages = with config.boot.kernelPackages; [ yt6801 ];
    zfs = {
      forceImportRoot = false; # default from 26.11
    };
    kernelParams = [
      "acpi.ec_no_wakeup=1" # Fixes ACPI wakeup issues
      "amdgpu.dcdebugmask=0x10" # Fixes Wayland slowdowns/freezes
    ];
    loader = {
      systemd-boot = {
        enable = true;
      };
    };
  };
}
