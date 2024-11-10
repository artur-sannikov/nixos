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
    libva-utils
    lm_sensors
    nano
    nmap
    micromamba
    pciutils
    python312
    quickemu
    stress-ng
    vim
    vulkan-tools
    wayland-utils
    wget
  ];

  # Hardware hybrid decoding
  nixpkgs.config.packageOverrides = pkgs: {
    vaapiIntel = pkgs.vaapiIntel.override { enableHybridCodec = true; };
  };

  programs = {
    partition-manager.enable = true;
  };
}
