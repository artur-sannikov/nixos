{
  flake.modules.nixos.gaming =
    { username, ... }:
    # For reference https://wiki.archlinux.org/title/GameMode
    {
      programs = {
        gamemode = {
          enable = true;
          enableRenice = true;
          settings = {
            general = {
              renice = 10;
            };
          };
        };
      };
      users = {
        users = {
          ${username} = {
            extraGroups = [
              "gamemode"
            ];
          };
        };
      };
    };
}
