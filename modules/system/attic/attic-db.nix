{
  flake.modules.nixos.attic = { pkgs, ... }: {
    services = {
      postgresql = {
        enable = true;
        enableJIT = true;
        enableTCPIP = false;
        package = pkgs.postgresql_17_jit;
        settings = {
          port = 5432;
          max_connections = 100;
        };
        ensureDatabases = [
          "atticd"
        ];
        ensureUsers = [
          {
            name = "atticd";
            ensureDBOwnership = true;
          }
          {
            name = "forgejo";
            ensureDBOwnership = true;
          }
        ];
        authentication = ''
          # Local services
          local forgejo forgejo peer
          local atticd atticd peer
          host atticd atticd 127.0.0.1/32 trust
        '';
      };
    };
  };
}
