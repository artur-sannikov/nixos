{ inputs, ... }:
{
  flake.modules.nixos.ntfy-sh = {
    imports = with inputs.self.modules.nixos; [
      caddy
    ];
    services = {
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
          virtualHosts = {
            "ntfy.asannikov.com" = ntfyShConfig;
            "http://ntfy.asannikov.com" = ntfyShConfig;
          };
        };
    };

  };
}
