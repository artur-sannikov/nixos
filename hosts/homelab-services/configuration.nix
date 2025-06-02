# Edit this configuration file to define what should be installed on
# your system. Help is available in the configuration.nix(5) man page, on
# https://search.nixos.org/options and in the NixOS manual (`nixos-help`).

{
  config,
  lib,
  pkgs,
  pkgs-stable,
  username,
  flake-inputs,
  ...
}:
let
  forgejoRootUrl = "https://forgejo.${flake-inputs.nix-secrets.domain}";
  forgejoDomain = "git.${flake-inputs.nix-secrets.domain}";
in
{
  imports = lib.flatten [
    (map lib.custom.relativeToRoot [
      "hosts/homelab-services/disko.nix"
      "modules/system/services/openssh.nix"
      "modules/system/maintenence.nix"
      "modules/system/virtualization/docker.nix"
      "modules/core/default.nix"
    ])
  ];

  boot = {
    loader = {
      grub = {
        enable = true;
        efiSupport = true;
        efiInstallAsRemovable = true;
        device = "nodev";
      };
    };
  };

  networking = {
    hostName = "nix-services";
    firewall = {
      enable = true;
      allowedTCPPorts = [ 3000 ]; # Forgejo
    };
  };

  # Set your time zone.
  time.timeZone = "Europe/Helsinki";

  # Mount NFS
  fileSystems = {
    "/mnt/nas/photos" = {
      device = "192.168.20.5:/mnt/tank/personal/photos";
      fsType = "nfs";
      options = [
        "x-systemd.automount"
        "nofail"
        "noauto"
        "_netdev"
      ];
    };
  };

  # Enable Flakes
  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];

  # Secrets
  sops = {
    secrets = {
      forgejo-runner-token = { };
    };
  };

  services = {
    qemuGuest.enable = true;
    tailscale = {
      enable = true;
      package = pkgs-stable.tailscale;
    };
    immich = {
      enable = true;
      user = "immich";
      group = "immich";
      openFirewall = true;
      host = "0.0.0.0";
      mediaLocation = "/mnt/nas/photos";
    };
    forgejo = {
      enable = true;
      package = pkgs.forgejo;
      user = "forgejo";
      group = "forgejo";
      lfs.enable = true;
      dump = {
        enable = true;
        type = "tar.gz";
        backupDir = "/home/${username}/forgejo-backups";
        interval = "hourly";
      };
      settings = {
        server = {
          DOMAIN = forgejoDomain;
          ROOT_URL = forgejoRootUrl;
        };
        service.DISABLE_REGISTRATION = true;
      };
    };
    gitea-actions-runner = {
      package = pkgs.forgejo-actions-runner;
      instances.default = {
        enable = true;
        name = "renovate";
        url = forgejoRootUrl;
        tokenFile = config.sops.secrets.forgejo-runner-token.path;
        labels = [
          "debian-latest:docker://node:23-bookworm"
        ];
      };
    };
  };

  # Required for Forgejo actions
  virtualisation = {
    podman = {
      enable = true;
    };
  };

  environment.systemPackages = with pkgs; [
    git
  ];

  security = {
    rtkit.enable = true;
    apparmor = {
      enable = true;
      killUnconfinedConfinables = true;
      packages = [ pkgs.apparmor-profiles ];
    };
  };

  users = {
    users = {
      ${username} = {
        isNormalUser = true;
        extraGroups = [
          "wheel"
        ];
        openssh.authorizedKeys.keys = [
          "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIJMZJpTUgJSW8XTfLyURldokF828j3G8yOR45xjFQX/H"
        ];
        initialHashedPassword = "$y$j9T$V7USJgwWqoEDnUa0pMjb30$E5mDIdm9KnS9aLu61AYVYTGdcGwFHUtOR4UWCb8wWh3"; # Initlal  password to be changed after first login
      };
      immich = {
        isSystemUser = true;
        group = "immich";
      };
      forgejo = {
        isSystemUser = true;
      };
    };
    groups = {
      immich.gid = 1002;
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
}
