{
  pkgs,
  pkgs-stable,
  ...
}:
# Install system-wide packages
{
  environment.systemPackages =
    with pkgs;
    [
      aha
      android-tools
      clinfo
      cyrus-sasl-xoauth2 # Required for mbsync email sync for outlook
      dig
      dmidecode
      exfat
      exfatprogs
      gcc
      git
      gparted
      inxi
      kdePackages.isoimagewriter
      libva-utils
      lm_sensors
      mesa-demos
      nano
      nfs-utils
      nixd
      nix-init
      nmap
      pciutils
      pv
      python313
      samba
      sbctl
      stress-ng
      system-config-printer
      unzip
      usbutils
      vim
      vulkan-tools
      wayland-utils
      wget
      wireguard-tools
    ]
    ++ (with pkgs-stable; [
      quickemu
      koboldcpp
    ]);

  programs = {
    partition-manager.enable = true;
  };
}
