{
  flake.modules.nixos.llama-rocm = { pkgs, ... }: {
    services = {
      llama-cpp = {
        enable = true;
        package = pkgs.llama-cpp-rocm;
      };
    };
    environment.systemPackages = [ pkgs.llama-cpp-rocm ];
  };
}
