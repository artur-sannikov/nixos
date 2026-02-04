{ config, pkgs, ... }:
{
  home = {
    packages = [
      pkgs.vdirsyncer
    ];
  };
  services = {
    vdirsyncer = {
      enable = true;
      configFile = "${config.xdg.configHome}/vdirsyncer/config";
      # configFile = {
      # general = {
      #   status_path = [ "~/.vdirsyncer/status" ];
      # };
    };
  };
}
