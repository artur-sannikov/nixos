{
  config,
  inputs,
  self,
  ...
}:
{
  flake = {
    nixosConfigurations.ty = config.flake.lib.mkNixos {
      hostName = "ty";
      modules = [
        ./_hardware-configuration.nix
        ./_boot.nix
        ./_filesystems.nix
        self.modules.nixos.workstation-work
        self.modules.nixos.laptop
        inputs.lanzaboote.nixosModules.lanzaboote
      ];
    };
  };
}
