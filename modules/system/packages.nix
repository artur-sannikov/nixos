{ pkgs, ... }:
# Install system-wide packages
{
  environment.systemPackages = with pkgs; [
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
    quickemu
    stress-ng
    unzip
    vim
    vulkan-tools
    wayland-utils
    wget
    wireguard-tools
  ];

  programs = {
    partition-manager.enable = true;
  };
}
