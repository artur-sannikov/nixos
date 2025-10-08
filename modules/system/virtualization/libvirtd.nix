{ pkgs, username, ... }:
{
  programs = {
    virt-manager = {
      enable = true;
    };
  };
  virtualisation.libvirtd = {
    allowedBridges = [
      "nm-bridge"
      "virbr0"
    ];
    enable = true;
    qemu = {
      runAsRoot = false;
      swtpm.enable = true; # Allows libvirtd to use swtpm to create an emulated TPM
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
  environment.systemPackages = [ pkgs.virt-viewer ];
}
