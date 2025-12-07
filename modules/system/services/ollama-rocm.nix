{ pkgs-stable, ... }:
{
  services = {
    ollama = {
      enable = true;
      package = pkgs-stable.ollama-rocm;
      rocmOverrideGfx = "11.0.0";
    };
    open-webui = {
      enable = true;
      package = pkgs-stable.open-webui;
    };
  };
}
