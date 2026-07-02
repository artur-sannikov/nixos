# Common configuration for my Forgejo instances
{
  flake.modules.nixos.forgejo-common =
    {
      pkgs,
      ...
    }:
    {
      services = {
        forgejo = {
          enable = true;
          package = pkgs.forgejo;
          # https://forgejo.org/docs/latest/admin/config-cheat-sheet/
          settings = {
            service = {
              DISABLE_REGISTRATION = true;
            };
            repository = {
              DISABLE_STARS = true;
            };
            other = {
              SHOW_FOOTER_VERSION = false;
            };
            server = {
              LANDING_PAGE = "explore";
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
          };
          lfs = {
            enable = true;
          };
        };
      };
      virtualisation = {
        podman = {
          enable = true;
        };
      };
      # For some reason, these rules are required for the network to work
      # inside the containers created by Forgejo
      # See https://reddit.com/r/NixOS/comments/199f16j/why_dont_my_podman_containers_have_internet_access/
      networking = {
        firewall = {
          interfaces = {
            podman1 = {
              allowedUDPPorts = [ 53 ];
            };
            podman2 = {
              allowedUDPPorts = [ 53 ];
            };
          };
        };
      };

    };
}
