{
  flake.modules.nixos.ntfy-sh = { config, ... }: {
    sops = {
      secrets = {
        "ntfy-sh/env" = { };
      };
    };
    services = {
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
  };
}
