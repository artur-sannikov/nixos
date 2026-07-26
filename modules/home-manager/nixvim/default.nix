{ inputs, config, ... }:
{
  systems = [
    "x86_64-linux"
  ];
  perSystem =
    { system, pkgs, ... }:
    let
      configuration = inputs.nixvim.lib.evalNixvim {
        inherit system;
        modules = [
          # It's a bit of a hacky solution
          # Unlike the legacy option makeNixvimWithModule, I cannot
          # inherit pkgs
          { nixpkgs.pkgs = pkgs; }
          config.flake.modules.nixvim.default
        ];
      };
    in
    {
      checks.nvim = configuration.config.build.test;
      packages.nvim = configuration.config.build.package;
    };
}
