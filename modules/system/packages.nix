{
  pkgs,
  pkgs-stable,
  flake-inputs,
  ...
}:
# Install system-wide packages
{
  environment.systemPackages =
    with pkgs;
    [

      flake-inputs.winboat.packages."x86_64-linux".winboat
      aha
      air-formatter
      clinfo
      cyrus-sasl-xoauth2 # Required for mbsync email sync for outlook
      dig
      dmidecode
      exfat
      exfatprogs
      gcc
      git
      glxinfo
      gparted
      inxi
      isoimagewriter
      libva-utils
      lm_sensors
      nano
      nfs-utils
      nixd
      nix-init
      nmap
      pciutils
      pre-commit
      pv
      python313
      samba
      sanoid
      ssh-audit
      stress-ng
      system-config-printer
      typstyle
      unzip
      usbutils
      vim
      vulkan-tools
      wayland-utils
      wget
      wireguard-tools
    ]
    ++ (with pkgs-stable; [
      quickemu
      koboldcpp
    ]);

  programs = {
    partition-manager.enable = true;
  };
}
