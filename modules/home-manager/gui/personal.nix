{
  inputs,
  pkgs,
  pkgs-stable,
  ...
}:
{
  # Personal apps
  flake.modules.homeModules.personal = {
    imports = with inputs.self.modules.homeModules; [
      gui
    ];
    home.packages =
      with pkgs;
      [
        audacity
        kdePackages.kcalc
        kdePackages.konversation
        moonlight-qt
        monero-gui
        picard
        telegram-desktop
        tor-browser
        veracrypt
      ]
      ++ (with pkgs-stable; [
        calibre
        flacon
        rustdesk-flutter
        signal-desktop
      ]);
  };
}
