{ inputs, self, ... }:
{
  flake.modules.nixos.workstation = {
    imports = with inputs.self.modules.nixos; [
      appimage
      audio
      attic-watch-store
      base
      bluetooth
      fonts
      graphics
      email
      fwupd
      nvme-rs
      qmk
      gui # zoom and browsers
      cli
      home-manager
      stylix
      ssh
      syncthing
      virtualization
      secureboot
      locale
      zramswap
      plasma-de # Plasma 6
      networkmanager
      nix

      podman-auto-update
      metube

      # User
      users-artur
    ];
    users = {
      users = {
        artur = {
          extraGroups = [
            "input"
          ];
        };
      };
    };
    home-manager.users.artur.imports = with self.modules.homeManager; [
      accounts
      base
      cli
      email
      sops
      stylix
      duplicacy-web
    ];
  };
}
