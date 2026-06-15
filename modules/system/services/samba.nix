{
  flake.modules.nixos.samba = {
    services = {
      samba = {
        enable = true;
        settings = {
          global = {
            security = "user";
            "workgroup" = "utu";
          };
        };
      };
    };
  };
}
