{
  flake.modules.nixos.fail2ban = {
    services = {
      fail2ban = {
        enable = true;
        bantime = "1h";
        bantime-increment = {
          enable = true;
          factor = "4";
          maxtime = "168h";
          overalljails = true;
        };
      };
    };
  };
}
