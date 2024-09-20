{ pkgs, ... }:
# Install system-wide packages
{
  environment.systemPackages = with pkgs; [
    aha
    clinfo
    dig
    git
    glxinfo
    libva-utils
    nano
    nmap
    pciutils
    python312
    vim
    vulkan-tools
    wayland-utils
    wget
  ];

  # Hardware hybrid decoding
  nixpkgs.config.packageOverrides = pkgs: {
    vaapiIntel = pkgs.vaapiIntel.override { enableHybridCodec = true; };
  };
}
