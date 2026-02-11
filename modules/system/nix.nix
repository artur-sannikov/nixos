{

  nix = {
    settings = {
      # List of binary cache URLs that non-root users can use
      trusted-substituters = [
        "https://rstats-on-nix.cachix.org/"
        "https://nix-community.cachix.org/"
      ];
      trusted-public-keys = [
        "rstats-on-nix.cachix.org-1:vdiiVgocg6WeJrODIqdprZRUrhi1JzhBnXv7aWI6+F0="
        "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
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
