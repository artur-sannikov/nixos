{ self, ... }:
{
  flake.modules.nixos.forgejo-public =
    {
      config,
      lib,
      pkgs,
      ...
    }:
    {
      imports = [ self.modules.nixos.forgejo-common ];

      sops = {
        secrets = {
          "forgejo/public/forgejo-runner-token" = { };
        };
      };

      services = {
        forgejo = {
          database = {
            type = "postgres";
            createDatabase = true;
          };
          settings = {
            server = {
              DOMAIN = "git.asannikov.com";
              ROOT_URL = "https://git.asannikov.com/";
            };

            actions = {
              ENABLED = true;
              DEFAULT_ACTIONS_URL = "https://git.asannikov.com";
            };
          };
        };

        # See for configuration:
        # https://github.com/BCNelson/nix-config/blob/ec18349585f7a7c6a6cab72382d9b5d7b99473fe/nixos/romeo/services/forgejo-runner.nix#L33
        gitea-actions-runner =
          let
            labels = [
              "docker:docker://node:24-alpine"
              "alpine-latest:docker://node:24-alpine"
              "debian-latest:docker://node:24-trixie"
            ];
          in
          {
            package = pkgs.forgejo-runner;
            instances = {
              main = {
                enable = true;
                name = "main";
                url = "https://git.asannikov.com";
                # Still required by the module
                # See this rewrite https://github.com/NixOS/nixpkgs/pull/529621
                token = "connection-configured";
                inherit labels;
                settings = {
                  runner = {
                    capacity = 1;
                  };
                  server.connections.forgejo = {
                    url = "https://git.asannikov.com";
                    uuid = "c7bd2769-18cd-4af1-81d0-cfdeeaf8891f";
                    token_url = "file:$CREDENTIALS_DIRECTORY/forgejo-token";
                    inherit labels;
                  };
                };
              };
            };
          };
      };
      # Provide Forgejo token as a systemd credential
      systemd.services.gitea-runner-main.serviceConfig = {
        ExecStartPre = lib.mkForce [ ];
        LoadCredential = "forgejo-token:${config.sops.secrets."forgejo/public/forgejo-runner-token".path}";
      };

      # Use it for loopback for Forgejo actions I tried setting the forgejo
      # instance url to http://127.0.0.1:3000 but action containers lost
      # internet connectivity
      networking.hosts."127.0.0.1" = [
        "git.asannikov.com"
      ];
    };
}
