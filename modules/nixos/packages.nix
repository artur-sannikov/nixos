{
  flake.modules.nixos.cli =
    { pkgs, ... }:
    # Install system-wide packages
    {
      environment.systemPackages =
        with pkgs;
        [
          # p7zip
          aha
          android-tools
          cabextract
          clinfo
          cyrus-sasl-xoauth2 # Required for mbsync email sync for outlook
          dig
          dmidecode
          exfat
          exfatprogs
          gcc
          gparted
          inxi
          # kdePackages.isoimagewriter
          # koboldcpp
          libva-utils
          lm_sensors
          mesa-demos
          mono
          nano
          nfs-utils
          nixd
          nix-init
          nmap
          pciutils
          pv
          python313
          samba
          sbctl
          stress-ng
          system-config-printer
          unzip
          usbutils
          vim
          vulkan-tools
          wayland-utils
          wget
          wireguard-tools
        ]
        ++ (with pkgs.stable; [
          quickemu
        ]);
    };
}
