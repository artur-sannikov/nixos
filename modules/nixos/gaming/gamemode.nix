{
  flake.modules.nixos.gaming =
    { username, ... }:
    # For reference https://wiki.archlinux.org/title/GameMode
    {
      programs = {
        gamemode = {
          enable = true;
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
