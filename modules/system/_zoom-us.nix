{
  flake.modules.nixosModules.gui = {
    programs = {
      zoom-us = {
        enable = true;
      };
    };
  };
}
