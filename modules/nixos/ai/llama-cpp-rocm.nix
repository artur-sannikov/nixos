{
  flake.modules.nixos.llama-rocm = { pkgs, ... }: {
    services = {
      llama-cpp = {
        enable = true;
        package = pkgs.llama-cpp-rocm;
      };
    };
  };
}
