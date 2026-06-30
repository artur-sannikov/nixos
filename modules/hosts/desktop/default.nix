{
  config,
  inputs,
  self,
  ...
}:
{
  flake = {
    nixosConfigurations.desktop = config.flake.lib.mkNixos {
      hostName = "desktop";
      modules = [
        # Host-specific hardware and disk configurations
        ./_hardware-configuration.nix
        ./_boot.nix
        ./_filesystems.nix
        self.modules.nixos.workstation-personal
        self.modules.nixos.desktop
        self.modules.nixos.amdgpu # Enables overclocking
        inputs.disko.nixosModules.disko
        inputs.lanzaboote.nixosModules.lanzaboote
      ];
    };
  };
}
