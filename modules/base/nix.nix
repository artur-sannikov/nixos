{
  flake.modules.nixos.nix = { config, ... }: {
    sops = {
      secrets = {
        "atticd/netrc" = { };
      };
    };
    nix = {
      settings = {
        # List of binary cache URLs that non-root users can use
        trusted-substituters = [
          "https://rstats-on-nix.cachix.org"
        ];
        trusted-public-keys = [
          "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
          "numtide.cachix.org-1:2ps1kLBUWjxIneOy1Ik6cQjb41X0iXVXeHigGmycPPE="
          "rstats-on-nix.cachix.org-1:vdiiVgocg6WeJrODIqdprZRUrhi1JzhBnXv7aWI6+F0="
          "main:qry3jdoFrVZ1PwPUhJaZix3S2LBLE6fRMXoxk/yNvvQ="
        ];
        # Only used by Nix
        substituters = [
          "https://nix-community.cachix.org"
          "https://numtide.cachix.org"
          "https://cache.asannikov.com/main"
        ];
        experimental-features = [
          "nix-command"
          "flakes"
        ];
        trusted-users = [ "@wheel" ];
        netrc-file = config.sops.secrets."atticd/netrc".path;
      };
    };
  };
}
