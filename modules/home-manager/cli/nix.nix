{
  flake.modules.homeManager.cli = { pkgs, ... }: {
    home = {
      packages = with pkgs; [
        cachix
        nixfmt
        nixd
      ];
    };
  };
}
