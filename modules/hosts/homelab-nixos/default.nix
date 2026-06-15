{
  config,
  inputs,
  self,
  ...
}:
{
  flake = {
    nixosConfigurations.homelab-nixos = config.flake.lib.mkNixos {
      hostName = "homelab-nixos";
      modules = [
        # Host-specific hardware and disk configurations
        ./_disko.nix
        ./_hardware-configuration.nix
        ./_filesystems.nix
        {
          users = {
            users = {
              artur = {
                openssh = {
                  # homelab-nixos specific ssh keys
                  authorizedKeys.keys = [
                    "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIJMZJpTUgJSW8XTfLyURldokF828j3G8yOR45xjFQX/H"
                    "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIFgZdLpHM/8kW/dpJPt4UFF3sR8/0NRCLhs7Ri6Q8KFR"
                    "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIHtE3vYbcfqCKSjLOJQFVqin2pGH3IxmpV9/db1Q5SNw"
                  ];
                };
              };
            };
          };
        }
        inputs.disko.nixosModules.disko
      ]
      ++ (with self.modules.nixos; [
        grub
        server
        forgejo-private
        users-artur
        qemuguest # Proxmox node
      ]);
    };
  };
}
