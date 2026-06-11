{
  flake.modules.nixosModules.ollama-cpu = { pkgs, ... }: {
    services = {
      ollama = {
        enable = true;
        package = pkgs.ollama-cpu;
      };
    };
  };
}
