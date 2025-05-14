{
  services = {
    fwupd = {
      enable = true;
    };
    samba = {
      enable = true;
      settings = {
        global = {
          security = "user";
          "workgroup" = "utu";
        };
      };
    };
    chrony = {
      enable = true;
    };
  };
}
