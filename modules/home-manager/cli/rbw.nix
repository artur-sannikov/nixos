{ flake-inputs, pkgs, ... }:
{
  flake.modules.homeModules.cli = {
    programs = {
      rbw = {
        enable = true;
        settings = {
          pinentry = pkgs.pinentry-qt;
          email = "${flake-inputs.nix-secrets.email.bitwarden}";
          lock_timeout = 14400;
        };
      };
    };
  };
}
