{ username, lib, ... }:
{

  imports = lib.flatten [
    (map lib.custom.relativeToRoot [
      "hosts/hetzner1"
    ])
  ];
  deployment = {
    targetHost = "hetzner1";
    targetUser = "${username}";
    buildOnTarget = true;
  };
}
