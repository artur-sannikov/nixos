{ pkgs, ... }:
# Install system-wide packages
{
  environment.systemPackages = with pkgs; [
    aha
    clinfo
    dig
    dmidecode
    git
    glxinfo
    libva-utils
    lm_sensors
    nano
    nmap
    pciutils
    python312
    quickemu
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
}
