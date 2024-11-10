{ flake-inputs, ... }:
{
  system.autoUpgrade = {
    enable = true;
    flake = flake-inputs.self.outPath;
    flags = [
      "nixpkgs"
      "--commit-lock-file"
      "-L" # print build logs
    ];
    dates = "18:00";
    randomizedDelaySec = "45min";
  };

  nix = {
    settings.auto-optimise-store = true;
    optimise = {
      automatic = true;
      dates = [ "weekly" ];
    };
    gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 30d";
    };

  };
}
