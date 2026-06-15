{ self, ... }:
{
  flake.modules.nixos.forgejo-public =
    { config, pkgs, ... }:
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

        # Forgejo backup
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
      };
    };
}
