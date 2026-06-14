{
  flake.modules.nixos.sudo = {
    security = {
      sudo = {
        extraConfig = ''
          Defaults timestamp_timeout=120 # Ask sudo password every 2 hours
        '';
      };
    };
  };
}
