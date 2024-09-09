# Edit this configuration file to define what should be installed on
# your system. Help is available in the configuration.nix(5) man page, on
# https://search.nixos.org/options and in the NixOS manual (`nixos-help`).

{
  config,
  lib,
  nixpkgs-unstable,
  username,
  pkgs,
  flake-inputs,
  ...
}:
{
  imports = [
    # Include the results of the hardware scan.
    ./hardware-configuration.nix
    ./disko.nix
    ../../modules/system/virtualization/libvirtd.nix
    ../../modules/system/virtualization/bottles.nix
    ../../modules/system/virtualization/podman.nix
    ../../modules/system/gaming.nix
    ../../modules/system/tailscale.nix
    # System-wide packages
    ../../modules/system/packages.nix
    # Syncthing
    ../../modules/system/syncthing.nix
    # SSH Agent
    ../../modules/system/ssh.nix

    ../../modules/system/appimage.nix
  ];

  sshAgent.enable = true;

  # Use the systemd-boot EFI boot loader.
  #  boot.loader.systemd-boot.enable = true;
  #  boot.loader.efi.canTouchEfiVariables = true;
  boot = {
    loader = {
      grub = {
        enable = true;
        efiSupport = true;
        efiInstallAsRemovable = true;
        device = "nodev";
      };
    };
    # kernelModules = [ "uinput" ];
  };

  networking.hostName = "asus"; # Define your hostname.
  # Pick only one of the below networking options.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.
  networking.networkmanager.enable = true; # Easiest to use and most distros use this by default.

  # Enable Flakes
  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];

  # Set your time zone.
  time.timeZone = "Europe/Helsinki";

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Select internationalisation properties.
  # i18n.defaultLocale = "en_US.UTF-8";
  # console = {
  #   font = "Lat2-Terminus16";
  #   keyMap = "us";
  #   useXkbConfig = true; # use xkb.options in tty.
  # };

  # Enable KDE Plasma 6.
  services.xserver.enable = true;
  services.displayManager.sddm = {
    enable = true;
    wayland.enable = true;
  };

  services.desktopManager.plasma6.enable = true;

  # Configure keymap in X11
  # services.xserver.xkb.layout = "us";
  # services.xserver.xkb.options = "eurosign:e,caps:escape";

  # Enable CUPS to print documents.
  # services.printing.enable = true;

  security = {
    rtkit.enable = true;
    # apparmor = {
    #   enable = true;
    #   killUnconfinedConfinables = true;
    #   packages = [ pkgs.apparmor-profiles ];
    # };
  };

  services.pipewire = {
    enable = true;
    pulse.enable = true;
  };

  hardware = {
    opengl = {
      enable = true;
      driSupport = true;
      driSupport32Bit = true;
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

  # Enable touchpad support (enabled default in most desktopManager).
  # services.libinput.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.${username} = {
    isNormalUser = true;
    extraGroups = [
      "wheel"
      "input"
      "networkmanager"
    ];
  };

  environment.sessionVariables = {
    # Enable Wayland for supported apps
    NIXOS_OZONE_WL = "1";
  };

  gaming = {
    enable = true;
    SteamUIScaling = "2"; # Fix Steam UI on High DPI monitors
  };

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  #   environment.systemPackages = with pkgs; [
  #     inputs.helix.packages."${pkgs.system}".helix
  #   ];

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  system.autoUpgrade = {
    enable = true;
    flake = flake-inputs.self.outPath;
    flags = [
      "--update-input"
      "nixpkgs"
      "--no-write-lock-file"
      "-L" # print build logs
    ];
    dates = "16:00";
    randomizedDelaySec = "45min";
  };

  # Flatpak
  services = {
    flatpak = {
      enable = true;
      update.onActivation = true;
      packages = [
        # "io.gitlab.librewolf-community"
        {
          appId = "us.zoom.Zoom";
          origin = "flathub";
          commit = "b9505f108b5f9acb2bbad83ac66f97b42bc6a75b9c28ed7b75dec1040e013305";
        } # Screen sharing is broken on Plasma on newer versions
      ];
    };
    # Prevent Intel CPU overheating
    thermald = {
      enable = true;
    };
    # Disable power-profiles-daemon to use TLP
    power-profiles-daemon = {
      enable = false;
    };
    # TLP - Optimize Linux Laptop Battery Life
    # ttps://linrunner.de/tlp/index.html
    tlp = {
      enable = true;
      settings = {

        # For all options see https://linrunner.de/tlp/settings/processor html
        CPU_SCALING_GOVERNOR_ON_AC = "performance";
        CPU_SCALING_GOVERNOR_ON_BAT = "powersave";
        CPU_ENERGY_PERF_POLICY_ON_BAT = "balance_power";
        CPU_ENERGY_PERF_POLICY_ON_AC = "performance";
        CPU_MIN_PERF_ON_AC = 0;
        CPU_MAX_PERF_ON_AC = 100;
        CPU_MIN_PERF_ON_BAT = 0;
        CPU_MAX_PERF_ON_BAT = 40;
        # Enable or disable Intel turbo boost
        CPU_BOOST_ON_AC = 1;
        CPU_BOOST_ON_BAT = 0;

        # For all options see https://linrunner.de/tlp/settings/battery.html
        START_CHARGE_THRESH_BAT0 = 40;
        STOP_CHARGE_THRESH_BAT0 = 80;

        # Exclude Bluetooth devices from autosuspend
        USB_EXCLUDE_BTUSB = 1;
      };
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

  # Open ports in the firewall.
  networking.firewall.allowedTCPPorts = [ 22000 ]; # Syncthing port
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # Copy the NixOS configuration file and link it from the resulting system
  # (/run/current-system/configuration.nix). This is useful in case you
  # accidentally delete configuration.nix.
  # system.copySystemConfiguration = true;

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

}
