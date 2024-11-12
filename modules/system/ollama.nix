{
  services = {
    ollama = {
      enable = true;
      acceleration = "rocm";
      rocmOverrideGfx = "11.0.0";
    };
    open-webui.enable = true;
  };
}
