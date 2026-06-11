{
  flake.modules.nixosModules.ssh = {
    programs = {
      ssh = {
        startAgent = true;
      };
    };
  };
}
