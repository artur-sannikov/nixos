{
  flake.modules.nixos.attic = { config, ... }: {
    sops = {
      secrets = {
        "atticd/server_token" = { };
      };
    };
    services = {
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
    };
    systemd.tmpfiles.rules = [
      "d /var/lib/atticd/storage 0750 atticd atticd"
    ];
  };
}
