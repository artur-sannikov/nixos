{ username, ... }:
{
  flake.modules.nixosModules.cli = {
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
