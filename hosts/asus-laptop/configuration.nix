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
    ../../modules/system/services.nix

    ../../modules/system/tmux.nix
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

  networking = {
    hostName = "asus";
    networkmanager.enable = true;
    # wg-quick.interfaces.wg0.configFile = "/etc/nixos/files/wireguard/wg0.conf";
  };

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

  stylix = {
    enable = true;
    image = ./scarlet_tree.png;
    base16Scheme = "${pkgs.base16-schemes}/share/themes/catppuccin-mocha.yaml";
    cursor = {
      package = pkgs.capitaine-cursors-themed;
      name = "Capitaine Cursors (Nord)";
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
