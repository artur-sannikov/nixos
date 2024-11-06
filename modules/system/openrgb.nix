{ pkgs, ... }:
{
  services.hardware.openrgb = {
    enable = true;
    package = pkgs.openrgb;
    motherboard = "amd";
  };

  # environment.systemPackages = [
  #   pkgs.openrgb-with-all-plugins
  # ];

}
