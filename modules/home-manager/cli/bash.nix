{
  config,
  lib,
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
