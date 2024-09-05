{ pkgs, ... }:
# Install system-wide packages
{
  environment.systemPackages = with pkgs; [
    git
    nano
    vim
    wget
  ];
}
