{ pkgs-stable, ... }:
{
  services = {
    ollama = {
      enable = true;
      package = pkgs-stable.ollama;
      acceleration = "rocm";
      rocmOverrideGfx = "11.0.0";
    };
    open-webui.enable = true;
  };
}
