{
  flake.modules.nixosModules.samba = {
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
