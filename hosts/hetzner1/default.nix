{ username, lib, ... }:
{

  imports = lib.flatten [
    (lib.custom.scanPaths ./.)
  ];

  deployment = {
    targetHost = "hetzner1";
    targetUser = "${username}";
    buildOnTarget = true;
  };
}
