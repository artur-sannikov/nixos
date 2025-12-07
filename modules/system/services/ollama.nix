{ pkgs-stable, ... }:
{
  services = {
    ollama = {
      enable = true;
      package = pkgs-stable.ollama-cpu;
    };
    open-webui = {
      enable = true;
      package = pkgs-stable.open-webui;
    };
  };
}
