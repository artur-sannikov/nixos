{ pkgs, pkgs-stable, ... }:
# Install system-wide packages
{
  environment.systemPackages =
    with pkgs;
    [
      nfs-utils
      aha
      air-formatter
      clinfo
      cyrus-sasl-xoauth2 # Required for mbsync email sync for outlook
      dig
      dmidecode
      exfat
      exfatprogs
      gcc
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
      pre-commit
      python312
      pv
      stress-ng
      samba
      sanoid
      ssh-audit
      system-config-printer
      typstyle
      nixd
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
