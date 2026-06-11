{ pkgs, ... }:
{
  flake.modules.nixosModules.virtualization = {
    programs = {
      singularity = {
        enable = true;
        package = pkgs.apptainer;
      };
    };
  };
}
