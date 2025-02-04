{ pkgs, pkgs-stable, ... }:
# Install system-wide packages
{
  environment.systemPackages =
    with pkgs;
    [
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
      nmap
      pciutils
      python312
      stress-ng
      sanoid
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
