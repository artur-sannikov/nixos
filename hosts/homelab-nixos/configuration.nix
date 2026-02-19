{
  config,
  lib,
  pkgs,
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
      "hosts/homelab-nixos/disko.nix"
      "modules/system/grub.nix"
      "modules/system/nix.nix"
      "modules/system/services/openssh.nix"
      "modules/system/maintenance.nix"
      "modules/system/services/tailscale.nix"
      "modules/system/services/immich.nix"
      "modules/system/virtualization/containers/default.nix"
      "modules/core/default.nix"
      "modules/system/timezone.nix"
    ])
  ];

  networking = {
    hostName = "homelab-nixos";
    firewall = {
      enable = true;
      allowedTCPPorts = [ 3000 ]; # Forgejo
    };
  };

  # Set your time zone.
  time.timeZone = "Europe/Helsinki";

  # Mount NFS
  fileSystems = {
    "/mnt/nas/backups/forgejo-dump" = {
      device = "192.168.20.5:/mnt/tank/personal/backups/forgejo-dump";
      fsType = "nfs";
      options = [
        "x-systemd.automount"
        "nofail"
        "noauto"
        "_netdev"
      ];
    };
  };

  # Secrets
  sops = {
    secrets = {
      homelab_nixos_passwd = {
        neededForUsers = true;
      };
      forgejo-runner-token = { };
      forgejo-runner-main-token = { };
      restic-forgejo-dump-backup-password = { };
    };
  };

  services = {
    openssh = {
      settings = {
        # Required for sudo auth with ssh private key
        AllowAgentForwarding = lib.mkForce "yes";
      };
    };
    qemuGuest.enable = true;
    restic = {
      backups = {
        forgejo-dump = {
          initialize = true;
          paths = [ (toString config.services.forgejo.dump.backupDir) ];
          repository = "/mnt/nas/backups/forgejo-dump";
          passwordFile = config.sops.secrets.restic-forgejo-dump-backup-password.path;
          pruneOpts = [
            "--keep-daily 7"
            "--keep-weekly 5"
            "--keep-monthly 12"
          ];
          timerConfig = {
            OnCalendar = "13:00"; # One hour after forgejo-dump
            Persistent = true;
          };
        };
      };
    };
    forgejo = {
      enable = true;
      package = pkgs.forgejo;
      lfs.enable = true;
      dump = {
        enable = true;
        type = "tar.gz";
        interval = "05:37";
        # This should remove all dumps every 2 days because restic handles
        # the real backup
        age = "2d";
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
      package = pkgs.forgejo-runner;
      instances = {
        default = {
          enable = true;
          name = "renovate";
          url = forgejoRootUrl;
          tokenFile = config.sops.secrets.forgejo-runner-token.path;
          labels = [
            "debian-latest:docker://node:24-trixie"
            "native:host"
          ];
        };
        main = {
          enable = true;
          name = "main";
          url = forgejoRootUrl;
          tokenFile = config.sops.secrets.forgejo-runner-main-token.path;
          labels = [
            "debian-latest:docker://node:24-trixie"
            "native:host"
          ];
        };
      };
    };
  };

  systemd = {
    # systemd timer to delete old Forgejo action containers
    # Forgejo action containers are updated and pulled automatically
    # They are not deleted automatically and occupy a lot of space
    # That's the only way I found to delete the old images
    # I use binaries from pkgs as the safest approach of running programs
    services = {
      podman-cleanup = {
        description = "Clean up renovate images";
        serviceConfig = {
          Type = "oneshot";
          User = "root";
          ExecStart = "${pkgs.writeShellScript "podman-cleanup" ''
            #!${pkgs.bash}/bin/bash
            set -euo pipefail

            ${pkgs.podman}/bin/podman image ls -a  \
            | ( ${pkgs.gnugrep}/bin/grep "renovate" || true ) \
            | ${pkgs.gawk}/bin/awk '{print $3}' \
            | ${pkgs.findutils}/bin/xargs --no-run-if-empty \
            ${pkgs.podman}/bin/podman rmi -f
          ''}";
        };
      };
    };
  };

  environment.systemPackages = with pkgs; [
    git
    tmux
  ];

  security = {
    rtkit.enable = true;
    apparmor = {
      enable = true;
      killUnconfinedConfinables = true;
      packages = [ pkgs.apparmor-profiles ];
    };
  };

  # Required for Forgejo actions
  virtualisation = {
    podman = {
      enable = true;
    };
  };

  users = {
    mutableUsers = false;
    users = {
      ${username} = {
        isNormalUser = true;
        hashedPasswordFile = config.sops.secrets.homelab_nixos_passwd.path;
        extraGroups = [
          "wheel"
        ];
        openssh.authorizedKeys.keys = [
          "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIJMZJpTUgJSW8XTfLyURldokF828j3G8yOR45xjFQX/H"
          "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIFgZdLpHM/8kW/dpJPt4UFF3sR8/0NRCLhs7Ri6Q8KFR"
          "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIHtE3vYbcfqCKSjLOJQFVqin2pGH3IxmpV9/db1Q5SNw"
        ];
      };
      forgejo = {
        isSystemUser = true;
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
}
