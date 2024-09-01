{ pkgs, ... }:
{
  programs = {
    virt-manager = {
      enable = true;
    };
  };
  virtualisation.libvirtd = {
    allowedBridges = [
      "nm-bridge"
      "virbr0"
    ];
    enable = true;
    qemu = {
      runAsRoot = false;
      ovmf.enable = true;
    };
  };
}
