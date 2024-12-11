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

  # Hardware hybrid decoding
  nixpkgs.config.packageOverrides = pkgs: {
    vaapiIntel = pkgs.vaapiIntel.override { enableHybridCodec = true; };
  };

  programs = {
    partition-manager.enable = true;
  };
}
