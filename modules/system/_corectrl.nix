{
  flake.modules.nixosModules.cli = {
    programs = {
      corectrl = {
        enable = true;
      };
    };
  };
}
