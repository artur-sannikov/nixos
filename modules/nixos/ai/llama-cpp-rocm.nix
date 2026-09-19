{
  flake.modules.nixos.llama-rocm = { pkgs, ... }: {
    services = {
      llama-cpp = {
        enable = true;
        package = pkgs.stable.llama-cpp-rocm;
      };
    };
    environment.systemPackages = [ pkgs.stable.llama-cpp-rocm ];
  };
}
