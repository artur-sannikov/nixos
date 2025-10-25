{ username, ... }:
{
  services = {
    xremap = {
      enable = true;
      serviceMode = "user";
      userName = "${username}";
      withWlroots = true;
      config = {
        modmap = [
          {
            name = "Global";
            remap = {
              "CapsLock" = "Esc";
            };
          }
        ];
      };
    };
  };
}
