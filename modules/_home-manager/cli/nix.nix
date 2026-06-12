{
  flake.modules.homeModules.cli = { pkgs, ... }: {
    home = {
      packages = with pkgs; [
        cachix
        nixfmt
        nixd
      ];
    };
  };
}
