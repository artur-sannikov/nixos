# Reverse proxy for public Forgejo instance
{ inputs, ... }:
{
  flake.modules.nixos.forgejo-public = {
    imports = with inputs.self.modules.nixos; [
      caddy
    ];
    services = {
      caddy = {
        virtualHosts = {
          "git.asannikov.com" = {
            extraConfig = ''
              reverse_proxy http://localhost:3000
            '';
          };
        };
      };
    };
  };
}
