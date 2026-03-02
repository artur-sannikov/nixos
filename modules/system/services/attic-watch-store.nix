{ config, pkgs, ... }:
# https://github.com/greg-hellings/nixos-config/blob/efc0bf09c2fce11f2eb5abd26444435a73f30de3/modules/nixos/home.nix
# https://github.com/islacantwin/nixos-config/blob/94a3bb71cb35519fbd4a3d720bc7bfca9b1f2749/modules/nixos/services/attic.nix
let
  user = "attic-client";
in

{
  users = {
    groups.${user} = { };
    users = {
      ${user} = {
        isSystemUser = true;
        group = user;
      };
    };
  };
  sops = {
    secrets = {
      "atticd/auth_token" = {
        owner = user;
        group = user;
        mode = "0400";
      };
    };
    templates = {
      "attic-config.toml" = {
        owner = user;
        group = user;
        mode = "0400";
        content = ''
          default-server = "default"

          [servers.default]
          endpoint = "https://cache.asannikov.com"
          token = "${config.sops.placeholder."atticd/auth_token"}"
        '';
      };
    };
  };
  systemd = {
    services = {
      attic-watch-store = {
        enable = true;
        description = "Attic client watch-store service";
        after = [ "network.target" ];
        wantedBy = [ "multi-user.target" ];
        environment = {
          XDG_CONFIG_HOME = "/var/lib/attic-watch-store";
        };
        serviceConfig = {
          User = user;
          Group = user;
          Type = "simple";
          Restart = "on-failure";
          RestartSec = "5s";

          # Memory constraints
          MemoryHigh = "5%";
          MemoryMax = "10%";

          # Hardening
          ProtectHome = true;
          PrivateTmp = true;
          ProtectClock = true;
          ProtectKernelTunables = true;
          ProtectKernelModules = true;
          ProtectKernelLogs = true;
          ProtectControlGroups = true;
          ProtectProc = "invisible";
          ProcSubset = "pid";
          LockPersonality = true;
          RestrictRealtime = true;
          MemoryDenyWriteExecute = true;
          NoNewPrivileges = true;
        };
        preStart = ''
          set -x
          mkdir -p $XDG_CONFIG_HOME/attic
          cp ${config.sops.templates."attic-config.toml".path} $XDG_CONFIG_HOME/attic/config.toml
        '';
        script = "${pkgs.attic-client}/bin/attic watch-store main";
      };
    };
    tmpfiles = {
      rules = [
        "d /var/lib/attic-watch-store 0750 ${user} ${user} -"
        "Z /var/lib/attic-watch-store 0750 ${user} ${user} -"
      ];
    };
  };
}
