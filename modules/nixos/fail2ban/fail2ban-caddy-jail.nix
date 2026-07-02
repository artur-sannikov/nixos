{
  flake.modules.nixos.fail2ban-caddy-jail = {
    services = {
      fail2ban = {
        jails = {
          caddy-status = {
            settings = {
              port = "http,https";
              filter = "caddy-status";
              logpath = "/var/log/caddy/access*.log";
              maxretry = 5;
              findtime = 60;
              backend = "auto";
            };
          };
        };
      };
    };
    environment = {
      etc = {
        "fail2ban/filter.d/caddy-status.conf" = {
          # https://muetsch.io/how-to-integrate-caddy-with-fail2ban.html
          text = ''
            [Definition]
            failregex = ^.*"remote_ip":"<HOST>",.*?"status":(?:401|403|404|500),.*$
            ignoreregex =
            datepattern = LongEpoch
          '';
        };
      };
    };
  };
}
