{

  nix = {
    settings = {
      # List of binary cache URLs that non-root users can use
      trusted-substituters = [
        "https://nix-community.cachix.org?priority=10"
        "https://numtide.cachix.org?priority=11"
        "https://rstats-on-nix.cachix.org?priority=12"
        "https://cache.asannikov.com/otter?priority=13"
      ];
      trusted-public-keys = [
        "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
        "numtide.cachix.org-1:2ps1kLBUWjxIneOy1Ik6cQjb41X0iXVXeHigGmycPPE="
        "rstats-on-nix.cachix.org-1:vdiiVgocg6WeJrODIqdprZRUrhi1JzhBnXv7aWI6+F0="
        "otter:qry3jdoFrVZ1PwPUhJaZix3S2LBLE6fRMXoxk/yNvvQ="
      ];
      trusted-users = [
        "root"
        "@wheel"
      ];
      experimental-features = [
        "nix-command"
        "flakes"
      ];
    };
  };
}
