# Insipred by https://github.com/pschmitt/nixos-config/blob/ae4b2fc0c0e8b4f53952d9039f8d6f31f3d71149/services/vdirsyncer.nix
{
  config,
  lib,
  pkgs,
  username,
  flake-inputs,
  ...
}:
let
  syncUser = "vdirsyncer";
  syncGroup = syncUser;
  stateDir = "/var/lib/${syncUser}";
  carddav_url = "https://nextcloud.${flake-inputs.nix-secrets.domain}/remote.php/dav/addressbooks/users/${username}/default/";
in
{
  environment = {
    systemPackages = with pkgs; [
      vdirsyncer
    ];
  };

  # Declare secrets
  sops = {
    secrets = {
      "vdirsyncer/nextcloud/username" = {
        owner = syncUser;
        group = syncGroup;
        mode = "0400";
      };
      "vdirsyncer/nextcloud/password" = {
        owner = syncUser;
        group = syncGroup;
        mode = "0400";
      };
    };
  };

  # Add vdirsyncer user and add main user to its group
  users = {
    groups = {
      ${syncGroup} = { };
    };
    users = {
      ${syncUser} = {
        isSystemUser = true;
        group = syncGroup;
        home = stateDir;
        createHome = true;
      };
      "${username}" = {
        extraGroups = [ "${syncGroup}" ];
      };
    };
  };
  services = {
    vdirsyncer = {
      enable = true;
      jobs = {
        default_job = {
          user = syncUser;
          group = syncGroup;
          forceDiscover = true;
          config = {
            # vdirsyncer storages
            storages = {
              default_local = {
                type = "filesystem";
                path = "/home/${username}/.contacts";
                fileext = ".vcf";
              };
              default_remote = {
                type = "carddav";
                read_only = true;
                url = carddav_url;
                username = "${username}";
                "password.fetch" = [
                  "command"
                  "cat"
                  config.sops.secrets."vdirsyncer/nextcloud/password".path
                ];
              };
            };
            # vdirsyncer pairs
            pairs = {
              default = {
                a = "default_local";
                b = "default_remote";
                collections = [
                  "from a"
                  "from b"
                ];
                conflict_resolution = "b wins";
                metadata = [ "displayname" ];
              };
            };
          };
          timerConfig = {
            OnCalendar = "hourly";
            RandomizedDelaySec = "900";
            Persistent = true;
          };
        };
      };
    };
  };
}
