{ flake-inputs, ... }:
{
  imports = [ flake-inputs.flatpaks.homeManagerModules.nix-flatpak ];
  services.flatpak.packages = [
    {
      appId = "com.brave.Browser";
      origin = "flathub";
    }
    "im.riot.Riot"
    "com.logseq.Logseq"
  ];
}
