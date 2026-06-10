{
  flake.nixosModules.base = {
    nixpkgs.config.allowUnfreePredicate =
      pkg:
      builtins.elem (pkg.pname or "") [
        "castlabs-electron"
        "duplicacy-web"
        "obsidian"
        "slack"
        "steam"
        "steam-unwrapped"
        "veracrypt"
        "via"
        "zoom"
      ];
    #   imports = [ inputs.sops-nix.nixosModules.sops ];
    #   sops = {
    #     defaultSopsFile = "${inputs.nix-secrets}/secrets.yaml";
    #     validateSopsFiles = false;
    #     age = {
    #       sshKeyPaths = [ "/etc/ssh/ssh_host_ed25519_key" ];
    #       keyFile = "/var/lib/sops-nix/key.txt";
    #       generateKey = true;
    #     };
    #   };
  };
}
