{ pkgs-stable, ... }:
{
  services = {
    ollama = {
      enable = true;
      package = pkgs-stable.ollama-cpu;
    };
    open-webui = {
      enable = false;
      package = pkgs-stable.open-webui;
    };
  };
}
