{
  flake.modules.nixosModules.virtualization = { pkgs, ... }: {
    programs = {
      singularity = {
        enable = true;
        package = pkgs.apptainer;
      };
    };
  };
}
