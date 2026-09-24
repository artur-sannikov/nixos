{
  flake.modules.nixos.borg-backup-tuxedo =
    {
      config,
      lib,
      pkgs,
      username,
      ...
    }:
    {
      sops = {
        secrets = {
          "borg/tuxedo-ssh-key" = { };
          "borg/tuxedo-passphrase" = { };
          "borg/known-hosts" = { };
          "borg/borgmatic-ntfy-token" = { };
        };
      };
      # Load ntfy topic and access token as systemd credential
      systemd = {
        timers.borgmatic.timerConfig = {
          OnCalendar = lib.mkForce "*-*-* */4:00:00";
          Persistent = true;
        };
        services.borgmatic.serviceConfig = {
          LoadCredential = [
            "borgmatic_ntfy_token:${config.sops.secrets."borg/borgmatic-ntfy-token".path}"
          ];
        };
      };
      services.borgmatic = {
        enable = true;
        settings = {
          source_directories = [
            "/home/${username}/Desktop"
            "/home/${username}/Documents"
            "/home/${username}/Maildir"
            "/home/${username}/Zotero"
            "/home/${username}/.config"
            "/home/${username}/.gnupg"
            "/home/${username}/.ssh"
            "/home/${username}/.thunderbird"
            "/home/${username}/.librewolf"
            "/home/${username}/.contacts"
          ];
          repositories = [
            {
              path = "ssh://u672686@u672686.your-storagebox.de:23/./borg-backups/tuxedo";
              label = "tuxedo";
            }
          ];
          encryption_passcommand = "cat ${config.sops.secrets."borg/tuxedo-passphrase".path}";
          ssh_command = ''
            ssh
              -i ${config.sops.secrets."borg/tuxedo-ssh-key".path}
              -o IdentitiesOnly=yes
              -o UserKnownHostsFile=${config.sops.secrets."borg/known-hosts".path}
          '';
          compression = "auto,zstd";
          keep_within = "1d";
          keep_daily = 7;
          keep_weekly = 4;
          keep_monthly = 6;

          checkpoint_interval = 300;

          exclude_patterns = [
            "**/.DS_Store"
            "**/.direnv"
            "**/*.swp"

            "**/.RData"
            "**/.RDataTmp"
            "**/.Rhistory"
            "**/.Rapp.history"

            "**/node_modules"
            "**/.npm"
            "**/.yarn"
            "**/.pnpm-store"

            "**/__pycache__"
            "**/.venv"
            "**/venv"

            # Can be redownloaded
            "**/*.iso"

            # Nix results can be big
            "**/result"

            # Nixpkgs repo
            "**/nixpkgs"

            # Old config
            "/home/${username}/.config/.config.old"
          ];

          checks = [
            {
              name = "repository";
              frequency = "2 weeks";
            }
            {
              name = "archives";
              frequency = "4 weeks";
            }
          ];

          ntfy = {
            topic = "borg-backups";
            access_token = "{credential systemd borgmatic_ntfy_token}";
            server = "https://ntfy.asannikov.com";
            start = {
              title = "Backup started";
              message = "Starting backup on tuxedo";
              priority = "low";
            };
            finish = {
              title = "Backup finished";
              message = "Backup completed successfully on tuxedo";
              priority = "low";
            };

            fail = {
              title = "Backup failed";
              message = "Backup failed on tuxedo";
              priority = "max";
            };
            states = [
              "start"
              "finish"
              "fail"
            ];
          };
        };
      };
      environment.systemPackages = [ pkgs.borgbackup ];
    };
}
