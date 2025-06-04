{ flake-inputs, username, ... }:
let
  secretspath = builtins.toString flake-inputs.nix-secrets;
in
{
  imports = [
    flake-inputs.sops-nix.homeManagerModules.sops
  ];

  sops = {
    defaultSopsFile = "${secretspath}/secrets.yaml";
    validateSopsFiles = false;
    age = {
      keyFile = "/home/${username}/.config/sops/age/keys.txt";
    };
  };
}
