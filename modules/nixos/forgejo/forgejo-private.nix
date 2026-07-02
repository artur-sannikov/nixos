{ self, inputs, ... }:
{
  flake.modules.nixos.forgejo-private =
    { config, pkgs, ... }:
    let
      forgejoRootUrl = "https://forgejo.${inputs.nix-secrets.domain}";
      forgejoDomain = "git.${inputs.nix-secrets.domain}";
    in
    {
      imports = [ self.modules.nixos.forgejo-common ];

      sops = {
        secrets = {
          homelab_nixos_passwd = {
            neededForUsers = true;
          };
          "forgejo/private/forgejo-runner-token" = { };
          "forgejo/private/forgejo-runner-main-token" = { };
          restic-forgejo-dump-backup-password = { };
        };
      };

      services = {
        forgejo = {
          dump = {
            enable = true;
            type = "tar.gz";
            interval = "05:37";
            age = "2d";
          };
          settings.server = {
            DOMAIN = forgejoDomain;
            ROOT_URL = forgejoRootUrl;
          };
        };

        # Forgejo backup
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
                OnCalendar = "13:00";
                Persistent = true;
              };
            };
          };
        };
        gitea-actions-runner = {
          package = pkgs.forgejo-runner;
          instances = {
            default = {
              enable = true;
              name = "renovate";
              url = forgejoRootUrl;
              tokenFile = config.sops.secrets."forgejo/private/forgejo-runner-token".path;
              labels = [
                "debian-latest:docker://node:24-trixie"
              ];
            };
            main = {
              enable = true;
              name = "main";
              url = forgejoRootUrl;
              tokenFile = config.sops.secrets."forgejo/private/forgejo-runner-main-token".path;
              labels = [
                "debian-latest:docker://node:24-trixie"
              ];
            };
          };
        };
      };

      systemd = {
        # systemd timer to delete old Forgejo action containers
        # Forgejo action containers are updated and pulled automatically
        # They are not deleted automatically and occupy a lot of space.
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
        timers = {
          podman-cleanup = {
            enable = true;
            description = "Clean up renovate images";
            wantedBy = [ "timers.target" ];
            timerConfig = {
              OnBootSec = "10m";
              OnUnitActiveSec = "24h";
              Persistent = true;
              Unit = "podman-cleanup.service";
            };
          };
        };
      };
      networking = {
        firewall = {
          enable = true;
          allowedTCPPorts = [ 3000 ]; # Forgejo
        };
      };
    };
}
