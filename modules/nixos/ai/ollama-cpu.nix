{
  flake.modules.nixos.ollama-cpu = { pkgs, ... }: {
    services = {
      ollama = {
        enable = true;
        package = pkgs.ollama-cpu;
      };
    };
  };
}
