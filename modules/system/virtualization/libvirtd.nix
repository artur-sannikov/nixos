{ pkgs, username, ... }:
{
  programs = {
    virt-manager = {
      enable = true;
    };
  };
  virtualisation = {
    libvirtd = {
      allowedBridges = [
        "nm-bridge"
        "virbr0"
      ];
      enable = false;
      qemu = {
        runAsRoot = false;
        # Allows libvirtd to use swtpm to create an emulated TPM
        swtpm = {
          enable = true;
        };
      };
    };
  };
  users = {
    users = {
      ${username} = {
        extraGroups = [
          "libvirtd"
          "kvm"
        ];
      };
    };
  };
  environment = {
    systemPackages = [ pkgs.virt-viewer ];
  };
}
