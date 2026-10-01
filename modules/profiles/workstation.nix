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
      nur
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
      niri
      networkmanager
      nix

      podman-auto-update
      metube

      mimetypes

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
      contact
      email
      sops
      stylix
      niri
      noctalia
      duplicacy-web
      virtualization
      mimetypes
    ];
  };
}
