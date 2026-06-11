{
  inputs,
  pkgs,
  pkgs-stable,
  ...
}:
{
  # Work apps
  flake.modules.homeModules.work = {
    imports = with inputs.self.modules.homeModules; [
      gui
    ];
    home.packages =
      (with pkgs; [
        slack
        teams-for-linux
        quickemu
      ])
      ++ (with pkgs-stable; [
        eduvpn-client
      ]);
  };
}
