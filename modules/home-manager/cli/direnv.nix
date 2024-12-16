{ pkgs, ... }:
{
  home.packages = with pkgs; [ direnv ]; # Required by lorri
  programs = {
    direnv = {
      enable = true;
      nix-direnv.enable = true;
      enableZshIntegration = true;
    };
  };
}
