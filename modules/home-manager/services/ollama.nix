{
  flake.modules.homeManager.ollama = { pkgs, ... }: {
    services = {
      ollama = {
        enable = true;
        package = pkgs.ollama;
        acceleration = false;
        port = 8555;
      };
    };
  };
}
