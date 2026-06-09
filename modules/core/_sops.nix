{
  flake-inputs,
  ...
}:
let
  secretspath = toString flake-inputs.nix-secrets;
in
{
  imports = [
    flake-inputs.sops-nix.nixosModules.sops
  ];
  sops = {
    defaultSopsFile = "${secretspath}/secrets.yaml";
    validateSopsFiles = false;
    age = {
      sshKeyPaths = [ "/etc/ssh/ssh_host_ed25519_key" ];
      keyFile = "/var/lib/sops-nix/key.txt";
      generateKey = true;
    };
  };
}
