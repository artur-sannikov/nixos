{ pkgs, ... }:
# Install system-wide packages
{
  environment.systemPackages = with pkgs; [
    git
    libva-utils
    nano
    vim
    wget
  ];

  # Hardware hybrid decoding
  nixpkgs.config.packageOverrides = pkgs: {
    vaapiIntel = pkgs.vaapiIntel.override { enableHybridCodec = true; };
  };
}
