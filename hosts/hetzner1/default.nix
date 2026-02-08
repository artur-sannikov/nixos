{ username, ... }:
{
  imports = "./";

  deployment = {
    targetHost = "hetzner1";
    targetUser = "${username}";
    buildOnTarget = true;
  };
}
