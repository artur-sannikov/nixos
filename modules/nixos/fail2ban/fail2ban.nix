{
  flake.modules.nixos.fail2ban = {
    services = {
      fail2ban = {
        enable = true;
        bantime-increment = {
          enable = true;
          factor = "4";
          maxtime = "72h";
          overalljails = true;
        };
      };
    };
  };
}
