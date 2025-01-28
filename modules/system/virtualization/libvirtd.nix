{ pkgs, ... }:
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
      ovmf = {
        enable = true;
        packages = [
          (pkgs.OVMF.override {
            secureBoot = true;
            tpmSupport = true;
          }).fd
        ];
      };
    };
  };
  environment.systemPackages = [ pkgs.virt-viewer ];
}
