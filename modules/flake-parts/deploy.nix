{ self, inputs, ... }:
let
  username = "artur";

  mkNode = hostName: {
    hostname = hostName;
    sshUser = username;
    interactiveSudo = false;
    profiles.system = {
      user = "root";
      path = inputs.deploy-rs.lib.x86_64-linux.activate.nixos self.nixosConfigurations.${hostName};
    };
  };
in
{
  flake.deploy.nodes = {
    hetzner1 = mkNode "hetzner1";
    homelab-nixos = mkNode "homelab-nixos";
  };

  perSystem = { system, ... }: {
    checks = inputs.deploy-rs.lib.${system}.deployChecks self.deploy;
  };
}
