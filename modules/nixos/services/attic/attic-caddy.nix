{ inputs, ... }:
{
  flake.modules.nixos.attic = {
    imports = with inputs.self.modules.nixos; [
      caddy
    ];
    services = {
      caddy = {
        virtualHosts = {
          "cache.asannikov.com" = {
            extraConfig = ''
              reverse_proxy http://localhost:8080
            '';
          };
        };
      };
    };
  };
}
