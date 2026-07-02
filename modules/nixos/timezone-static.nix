# This is for desktop and servers that do not move locations
{
  flake.modules.nixos.timezone-static = {
    time = {
      timeZone = "Europe/Helsinki";
    };
  };
}
