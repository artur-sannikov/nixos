{ inputs, ... }:
let
  secretspath = toString inputs.nix-secrets;
in
{
  flake.modules.homeManager.sops = { username, ... }: {
    imports = [
      inputs.sops-nix.homeManagerModules.sops
    ];

    sops = {
      defaultSopsFile = "${secretspath}/secrets.yaml";
      validateSopsFiles = false;
      age = {
        keyFile = "/home/${username}/.config/sops/age/keys.txt";
      };
    };
  };
}
