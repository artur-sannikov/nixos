{ inputs, ... }:
{
  flake.modules.homeManager.cli = { pkgs, ... }: {
    programs = {
      rbw = {
        enable = true;
        settings = {
          pinentry = pkgs.pinentry-qt;
          email = "${inputs.nix-secrets.email.bitwarden}";
          lock_timeout = 14400;
        };
      };
    };
  };
}
