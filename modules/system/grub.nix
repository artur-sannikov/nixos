{
  flake.modules.nixos.grub-efi = {
    boot.loader.grub = {
      enable = true;
      efiSupport = true;
      efiInstallAsRemovable = true;
      device = "nodev";
    };
  };
  flake.modules.nixos.grub-bios = {
    boot.loader.grub = {
      enable = true;
      device = "nodev";
    };
  };
}
