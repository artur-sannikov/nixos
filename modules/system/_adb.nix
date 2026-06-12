{
  flake.modules.nixosModules.cli = { username, ... }: {
    programs = {
      adb = {
        enable = true;
      };
    };
    users = {
      users = {
        ${username} = {
          extraGroups = [ "adbusers" ];
        };
      };
    };
  };
}
