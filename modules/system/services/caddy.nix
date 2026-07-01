{
  flake.modules.nixos.caddy = {
    services = {
      caddy = {
        enable = true;
        openFirewall = true; # Ports 80 and 443
      };
    };
  };
}
