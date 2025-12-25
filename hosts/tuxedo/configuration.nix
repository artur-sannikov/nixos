# Edit this configuration file to define what should be installed on
# your system. Help is available in the configuration.nix(5) man page, on
# https://search.nixos.org/options and in the NixOS manual (`nixos-help`).

{
  username,
  pkgs,
  lib,
  config,
  ...
}:
{
  imports = lib.flatten [
    (map lib.custom.relativeToRoot [
      # Host-specific configuration
      "hosts/tuxedo/disko.nix"
      "hosts/tuxedo/hardware-configuration.nix"

      # Maintenence
      "modules/system/maintenance.nix"

      # Secure boot
      "modules/system/secureboot.nix"

      # Zram swap
      "modules/system/zramswap.nix"

      # Virtualization
      "modules/system/virtualization/bottles.nix"
      "modules/system/virtualization/containers/default.nix"
      "modules/system/virtualization/libvirtd.nix"
      "modules/system/virtualization/podman.nix"
      "modules/system/virtualization/singularity.nix"
      "modules/system/virtualization/docker.nix"

      # System-wide packages
      "modules/system/packages.nix"

      # Syncthing
      "modules/system/services/syncthing.nix"

      # SSH Agent
      "modules/system/services/ssh.nix"

      "modules/system/services/openssh.nix"

      # Remap keyboard keys
      "modules/system/services/xremap.nix"

      # Services
      "modules/system/services/audio.nix"
      "modules/system/services/mullvad.nix"
      "modules/system/services/ollama.nix"
      "modules/system/services/sanoid.nix"
      "modules/system/services/syncoid.nix"
      "modules/system/services/tailscale.nix"
      # "modules/system/services/tlp.nix"
      "modules/system/services/mbsyncd.nix"
      "modules/system/services/fwupd.nix"
      "modules/system/zoom-us.nix"

      # Browsers
      "modules/system/browsers"

      # Other system-related packages
      "modules/system/adb.nix"
      "modules/system/appimage.nix"
      "modules/system/gaming.nix"
      "modules/system/nix.nix"
      "modules/system/stylix.nix"
      # "modules/system/vaapi.nix"

      # Fonts
      "modules/system/fonts.nix"

      # locale
      "modules/system/locale.nix"

      # Import all core modules
      "modules/core/default.nix"

      # Wifi MAC randomization
      "modules/system/networking/wifi-mac-randomization.nix"
    ])
  ];

  config = {
    sshAgent.enable = true;

    boot = {
      extraModulePackages = with config.boot.kernelPackages; [ yt6801 ];
      kernelParams = [
        "acpi.ec_no_wakeup=1" # Fixes ACPI wakeup issues
        "amdgpu.dcdebugmask=0x10" # Fixes Wayland slowdowns/freezes
      ];
      loader = {
        systemd-boot.enable = true;
      };
    };

    networking = {
      hostName = "tuxedo";
      hostId = "2a2fff45";
      networkmanager = {
        enable = true;
        # device = {
        #   "wifi.scan-rand-mac-address" = "yes";
        # };
      };
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
      tuxedo-drivers.enable = true;
      graphics = {
        enable = true;
        enable32Bit = true;
        # extraPackages = with pkgs; [
        # intel-media-driver
        # vaapiIntel
        # vaapiVdpau
        # libvdpau-va-gl
        # ];
      };
      bluetooth = {
        enable = true;
        powerOnBoot = true;
      };
    };

    # Mount NFS
    fileSystems = {
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
      apparmor = {
        enable = true;
        killUnconfinedConfinables = true;
        packages = [ pkgs.apparmor-profiles ];
      };
    };

    # Secrets
    sops = {
      secrets = {
        artur_passwd = {
          neededForUsers = true;
        };
      };
    };

    users = {
      mutableUsers = false;
      users.${username} = {
        isNormalUser = true;
        hashedPasswordFile = config.sops.secrets.artur_passwd.path;
        extraGroups = [
          "wheel"
          "input"
          "networkmanager"
        ];
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
            sillytavern.enable = false;
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
