{
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
    open-webui = {
      enable = true;
      package = pkgs.open-webui;
    };
  };
}
