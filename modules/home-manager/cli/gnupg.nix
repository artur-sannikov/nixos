{ pkgs, ... }:
{
  programs.gpg.enable = true;
  services.gpg-agent = {
    enable = true;
    maxCacheTtl = 28800;
    defaultCacheTtl = 28800;
    pinentry.package = pkgs.pinentry-qt;
  };
}
