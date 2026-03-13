{ pkgs-stable, ... }:
{
  services = {
    ollama = {
      enable = false;
      package = pkgs-stable.ollama-cpu;
    };
    open-webui = {
      enable = false;
      package = pkgs-stable.open-webui;
    };
  };
}
