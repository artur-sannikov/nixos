{ pkgs, ... }:
{
  programs.chromium = {
    enable = true;
    package = pkgs.brave;
    extensions = [
      { id = "cjpalhdlnbpafiamejdnhcphjbkeiagm"; } # uBlock Origin
      { id = "nngceckbapebfimnlniiiahkandclblb"; } # Bitwarden
    ];
  };
}
