{ flake-inputs, pkgs, ... }:
{
  programs = {
    rbw = {
      enable = true;
      settings = {
        pinentry = pkgs.pinentry-qt;
        email = "${flake-inputs.nix-secrets.email.bitwarden}";
      };
    };
  };
}
