{
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
  ntpd-rs = {
    enable = true;
  };
}
