{
  config,
  inputs,
  self,
  ...
}:
{
  flake = {
    nixosConfigurations.tuxedo = config.flake.lib.mkNixos {
      hostName = "tuxedo";
      modules = [
        # Host-specific hardware and disk configurations
        ./_disko.nix
        ./_hardware-configuration.nix
        ./_boot.nix
        ./_filesystems.nix
        self.modules.nixos.workstation-personal
        self.modules.nixos.laptop
        self.modules.nixos.tuxedo-drivers # This is tuxedo machine
        inputs.disko.nixosModules.disko
        inputs.lanzaboote.nixosModules.lanzaboote
      ]
      ++ [ { networking.hostId = "2a2fff45"; } ]; # For ZFS
    };
  };
}
