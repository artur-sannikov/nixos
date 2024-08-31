{ config, pkgs, ... }:

{
  home.packages = with pkgs; [
    libvirt
    virt-manager
    qemu
  ];
}
