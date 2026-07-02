{
  config,
  inputs,
  self,
  ...
}:
{
  flake = {
    nixosConfigurations.hetzner1 = config.flake.lib.mkNixos {
      hostName = "hetzner1";
      modules = [
        # Host-specific hardware and disk configurations
        ./_disko.nix
        ./_hardware-configuration.nix
        self.modules.nixos.server
        self.modules.nixos.fail2ban
        self.modules.nixos.fail2ban-caddy-jail # Because it has caddy installed

        # Services
        self.modules.nixos.attic
        self.modules.nixos.forgejo-public
        self.modules.nixos.ntfy-sh

        self.modules.nixos.users-artur
        {
          users = {
            users = {
              artur = {
                openssh = {
                  # hetzner1 specific ssh keys
                  authorizedKeys.keys = [
                    "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIGIjp6rpHPkO5g7z3x/JUdKs2gEHnBENX7bvhCabWi82 artur@desktop"
                    "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAII00qwteq//W0ea7/jEQWgQ32GiW9Nx66VoOSSYAJVOC artur@tuxedo"
                    "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIAnU4V7O8BtERyz+m5lA4n0hM+66mRQaHyQyr6aMWnzs artur@ty"
                  ];
                };
              };
            };
          };
        }
        self.modules.nixos.grub-bios # Old Hetzner machines use GRUB
        inputs.disko.nixosModules.disko
      ];
    };
  };
}
