{
  config,
  lib,
  pkgs,
  ...
}:
{
  programs = {
    bash = {
      enable = true;
      historySize = 10000;
    };
  };
}
