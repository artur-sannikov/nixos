{ pkgs, ... }:
# Install systemd-wide packages
{
  environment.systemPackages = with pkgs; [
    git
    nano
    vim
    wget
  ];
}
