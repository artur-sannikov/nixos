# Edit this configuration file to define what should be installed on
# your system. Help is available in the configuration.nix(5) man page, on
# https://search.nixos.org/options and in the NixOS manual (`nixos-help`).

{
  username,
  pkgs,
  ...
}:
{
  imports = [
    # Include the results of the hardware scan.
    ./hardware-configuration.nix
    ./disko.nix
    ../../modules/system/secureboot.nix
    ../../modules/system/zramswap.nix
    ../../modules/system/maintenence.nix
    ../../modules/system/virtualization/libvirtd.nix
    ../../modules/system/virtualization/bottles.nix
    ../../modules/system/virtualization/podman.nix
    ../../modules/system/virtualization/singularity.nix
    ../../modules/system/virtualization/containers/default.nix
    ../../modules/system/gaming.nix
    ../../modules/system/tailscale.nix
    # System-wide packages
    ../../modules/system/packages.nix
    # Syncthing
    ../../modules/system/syncthing.nix
    # SSH Agent
    ../../modules/system/ssh.nix

    ../../modules/system/appimage.nix
    ../../modules/system/services.nix
    ../../modules/system/mullvad.nix
    ../../modules/system/tlp.nix
    ../../modules/system/keyboard.nix
    ../../modules/system/nix.nix
    ../../modules/system/stylix.nix
    ../../modules/system/adb.nix
    ../../modules/system/vaapi.nix
    ../../modules/system/sancoid.nix
  ];

  config = {
    sshAgent.enable = true;

    boot = {
      loader = {
        systemd-boot.enable = true;
      };
    };

    networking = {
      hostName = "asus";
      hostId = "2a2fff45";
      networkmanager.enable = true;
      firewall = {
        allowedTCPPorts = [
          # Syncthing port
          22000
        ];
        allowedTCPPortRanges = [
          {
            # KDE connect Ports
            from = 1714;
            to = 1764;
          }
        ];
        allowedUDPPortRanges = [
          {
            from = 1714;
            to = 1764;
          }
        ];
      };
    };

    hardware = {
      graphics = {
        enable = true;
        enable32Bit = true;
        extraPackages = with pkgs; [
          intel-media-driver
          vaapiIntel
          vaapiVdpau
          libvdpau-va-gl
        ];
      };
      bluetooth = {
        enable = true;
        powerOnBoot = true;
      };
    };

    # Mount NFS
    fileSystems = {
      "/mnt/nas/backup" = {
        device = "192.168.20.5:/mnt/tank/ux5401-backup";
        fsType = "nfs";
        options = [
          "x-systemd.automount"
          "nofail"
          "noauto"
          "_netdev"
        ];
      };
      "/mnt/nas/media" = {
        device = "192.168.20.5:/mnt/tank/media";
        fsType = "nfs";
        options = [
          "x-systemd.automount"
          "nofail"
          "noauto"
          "_netdev"
        ];
      };
    };

    # Disable service because it fails frequently at rebuild
    # https://discourse.nixos.org/t/nixos-rebuild-switch-upgrade-networkmanager-wait-online-service-failure/30746/2
    systemd.services.NetworkManager-wait-online.enable = false;

    # Enable Flakes
    nix.settings.experimental-features = [
      "nix-command"
      "flakes"
    ];

    services = {
      # Enable KDE Plasma 6.
      xserver.enable = false;
      displayManager.sddm = {
        enable = true;
        wayland.enable = true;
      };
      desktopManager.plasma6.enable = true;
      # Enable sound
      pipewire = {
        enable = true;
        pulse.enable = true;
      };
      printing.enable = true;
      avahi = {
        enable = true;
        nssmdns4 = true;
        openFirewall = true;
      };
      automatic-timezoned.enable = true;
      geoclue2.geoProviderUrl = "https://api.beacondb.net/v1/geolocate";
    };

    security = {
      rtkit.enable = true;
      apparmor = {
        enable = true;
        killUnconfinedConfinables = true;
        packages = [ pkgs.apparmor-profiles ];
      };
    };

    users = {
      mutableUsers = true;
      users = {
        ${username} = {
          isNormalUser = true;
          initialHashedPassword = "$y$j9T$OgyVucf3fEyZw2tdmBScn0$CAhZxC5H14MjZc21DAVD7XWMiEOnncNAtIP35LaMAC9"; # Initlal  password to be changed after first login
          extraGroups = [
            "wheel"
            "input"
            "networkmanager"
          ];
        };
      };
    };

    environment.sessionVariables = {
      # Enable Wayland for supported apps
      NIXOS_OZONE_WL = "1";

      # Default configuration directory
      XDG_CONFIG_HOME = "$HOME/.config";
    };

    # Add ~/.local/bin/ to $PATH.
    environment.localBinInPath = true;

    gaming = {
      enable = true;
      SteamUIScaling = "2"; # Fix Steam UI on High DPI monitors
    };

    modules = {
      system = {
        virtualisation = {
          containers = {
            immich-remote-machine-learning.enable = false;
            sillytavern.enable = true;
          };
        };
      };
    };

    # This option defines the first version of NixOS you have installed on this particular machine,
    # and is used to maintain compatibility with application data (e.g. databases) created on older NixOS versions.
    #
    # Most users should NEVER change this value after the initial install, for any reason,
    # even if you've upgraded your system to a new NixOS release.
    #
    # This value does NOT affect the Nixpkgs version your packages and OS are pulled from,
    # so changing it will NOT upgrade your system - see https://nixos.org/manual/nixos/stable/#sec-upgrading for how
    # to actually do that.
    #
    # This value being lower than the current NixOS release does NOT mean your system is
    # out of date, out of support, or vulnerable.
    #
    # Do NOT change this value unless you have manually inspected all the changes it would make to your configuration,
    # and migrated your data accordingly.
    #
    # For more information, see `man configuration.nix` or https://nixos.org/manual/nixos/stable/options#opt-system.stateVersion .
    system.stateVersion = "24.05"; # Did you read the comment?
  };
}
