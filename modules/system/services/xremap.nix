{ username, ... }:
{
  services = {
    xremap = {
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
