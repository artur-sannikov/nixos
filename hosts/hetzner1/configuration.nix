{
  config,
  lib,
  pkgs,
  username,
  ...
}:

{
  imports = lib.flatten [
    (map lib.custom.relativeToRoot [
      "hosts/hetzner1/disko.nix"
      "hosts/hetzner1/hardware-configuration.nix"
      "modules/system/services/openssh.nix"
      "modules/system/maintenance.nix"
      "modules/system/nix.nix"
      "modules/system/timezone.nix"
      "modules/core/default.nix"
    ])
  ];

  boot = {
    loader = {
      grub = {
        enable = true;
      };
    };
  };
  networking = {
    hostName = "hetzner1";
    firewall = {
      enable = true;
      allowedTCPPorts = [
        80
        443
      ];
    };
  };

  environment.systemPackages = with pkgs; [
    git
    tmux
    vim
    restic
  ];

  sops = {
    secrets = {
      artur_passwd = {
        neededForUsers = true;
      };
      "forgejo/public/forgejo-runner-token" = { };
      "atticd/server_token" = { };
      "ntfy-sh/env" = { };
    };
  };
  services = {
    openssh = {
      settings = {
        # Required for sudo auth with ssh private key
        AllowAgentForwarding = lib.mkForce "yes";
      };
    };
    forgejo = {
      enable = true;
      package = pkgs.forgejo;
      lfs = {
        enable = true;
      };
      database = {
        type = "postgres";
        createDatabase = true;
      };

      settings = {
        DEFAULT = {
          APP_NAME = "Artur's Git";
        };

        server = {
          LANDING_PAGE = "explore";
          DOMAIN = "git.asannikov.com";
          ROOT_URL = "https://git.asannikov.com/";
        };

        service = {
          DISABLE_REGISTRATION = true;
        };

        ui = {
          SHOW_USER_EMAIL = false;
          DEFAULT_SHOW_FULL_NAME = false;
        };

        session = {
          COOKIE_SECURE = true;
          PROVIDER = "db";
          PROVIDER_CONFIG = "";
          SESSION_LIFE_TIME = 86400 * 5;
        };

        actions = {
          ENABLED = true;
          DEFAULT_ACTIONS_URL = "https://git.asannikov.com";
        };

        repository = {
          DISABLE_STARS = true;
        };
      };
    };
    gitea-actions-runner = {
      package = pkgs.forgejo-runner;
      instances = {
        main = {
          enable = true;
          name = "main";
          url = "https://git.asannikov.com";
          tokenFile = config.sops.secrets."forgejo/public/forgejo-runner-token".path;
          labels = [
            "docker:docker://node:24-alpine"
            "alpine-latest:docker://node:24-alpine"
            "debian-latest:docker://node:24-trixie"
          ];
          settings = {
            runner = {
              capacity = 1;
            };
          };
        };
      };
    };
    caddy =
      let
        ntfyShConfig = {
          # https://docs.ntfy.sh/config/#nginxapache2caddy
          extraConfig = ''
             reverse_proxy http://localhost:7070
             @httpget {
                protocol http
                method GET
                path_regexp ^/([-_a-z0-9]{0,64}$|docs/|static/)
            }
            redir @httpget https://{host}{uri}
          '';
        };
      in
      {
        enable = true;
        virtualHosts = {
          "git.asannikov.com" = {
            extraConfig = ''
              reverse_proxy http://localhost:3000
            '';
          };
          "cache.asannikov.com" = {
            extraConfig = ''
              reverse_proxy http://localhost:8080
            '';
          };
          "ntfy.asannikov.com" = ntfyShConfig;
          "http://ntfy.asannikov.com" = ntfyShConfig;
        };
      };

    # This is for attic
    # Forgejo has its own database (port 5432)
    postgresql = {
      enable = true;
      enableJIT = true;
      enableTCPIP = false;
      package = pkgs.postgresql_17_jit;
      settings = {
        port = 5432;

        max_connections = 100;
      };
      ensureDatabases = [
        "atticd"
      ];
      ensureUsers = [
        {
          name = "atticd";
          ensureDBOwnership = true;
        }
        {
          name = "forgejo";
          ensureDBOwnership = true;
        }
      ];
      authentication = ''
        # Local services
        local forgejo forgejo peer
        local atticd atticd peer
        host atticd atticd 127.0.0.1/32 trust
      '';
    };
    atticd = {
      enable = true;
      environmentFile = config.sops.secrets."atticd/server_token".path;
      settings = {
        listen = "127.0.0.1:8080";
        allowed-hosts = [ "cache.asannikov.com" ];
        api-endpoint = "https://cache.asannikov.com/";
        jwt = { };
        database = {
          url = "postgresql://atticd@127.0.0.1:5432/atticd";
          heartbeat = true;
        };
        storage = {
          type = "local";
          path = "/var/lib/atticd/storage";
        };
      };
    };
    ntfy-sh = {
      enable = true;
      environmentFile = config.sops.secrets."ntfy-sh/env".path;
      settings = {
        base-url = "https://ntfy.asannikov.com";
        listen-http = "127.0.0.1:7070";
        behind-proxy = true;
        enable-signup = false;
        require-login = true;
        enable-login = true;
        auth-default-access = "deny-all";
      };
    };
  };
  systemd.tmpfiles.rules = [
    "d /var/lib/atticd/storage 0750 atticd atticd"
  ];

  # Required for Forgejo actions
  virtualisation = {
    podman = {
      enable = true;
    };
  };

  users = {
    mutableUsers = false;
    groups = {
      atticd = { };
    };
    users = {
      # Need atticd declarative storage creation
      atticd = {
        isSystemUser = true;
        group = "atticd";
        home = "/var/lib/atticd";
        createHome = true;
      };
      ${username} = {
        isNormalUser = true;
        hashedPasswordFile = config.sops.secrets.artur_passwd.path;
        extraGroups = [
          "wheel"
        ];
        openssh = {
          authorizedKeys = {
            keys = [
              "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIGIjp6rpHPkO5g7z3x/JUdKs2gEHnBENX7bvhCabWi82 artur@desktop"
              "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAII00qwteq//W0ea7/jEQWgQ32GiW9Nx66VoOSSYAJVOC artur@tuxedo"
              "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIAnU4V7O8BtERyz+m5lA4n0hM+66mRQaHyQyr6aMWnzs artur@ty"
            ];
          };
        };
      };
    };
  };
  system.stateVersion = "26.05";
}
