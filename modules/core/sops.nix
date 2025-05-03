{
  flake-inputs,
  ...
}:
let
  secretspath = builtins.toString flake-inputs.nix-secrets;
in
{
  imports = [
    flake-inputs.sops-nix.nixosModules.sops
  ];
  sops = {
    defaultSopsFile = "${secretspath}/secrets.yaml";
    age = {
      sshKeyPaths = [ "/etc/ssh/ssh_host_ed25519_key" ];
      keyFile = "/var/lib/sops-nix/key.txt";
      generateKey = true;
    };
  };
}
