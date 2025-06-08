{ pkgs, pkgs-stable, ... }:
# Install system-wide packages
{
  environment.systemPackages =
    with pkgs;
    [
      nfs-utils
      aha
      clinfo
      dig
      dmidecode
      exfat
      exfatprogs
      git
      glxinfo
      gparted
      inxi
      isoimagewriter
      koboldcpp
      libva-utils
      lm_sensors
      micromamba
      nano
      nix-init
      nmap
      pciutils
      python312
      stress-ng
      samba
      sanoid
      ssh-audit
      system-config-printer
      usbutils
      unzip
      vim
      vulkan-tools
      wayland-utils
      wget
      wireguard-tools
    ]
    ++ (with pkgs-stable; [
      quickemu
    ]);

  programs = {
    partition-manager.enable = true;
  };
}
