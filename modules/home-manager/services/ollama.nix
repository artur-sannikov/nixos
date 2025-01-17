{
  config,
  lib,
  pkgs,
  ...
}:
{
  services = {
    ollama = {
      enable = true;
      package = pkgs.ollama;
      acceleration = false;
      port = 8555;
    };
  };
}
