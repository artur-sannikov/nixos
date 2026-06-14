{
  inputs,
  ...
}:
{
  # Personal apps
  flake.modules.homeManager.gui-personal = { pkgs, pkgs-stable, ... }: {
    imports = with inputs.self.modules.homeManager; [
      gui
    ];
    home.packages =
      with pkgs;
      [
        audacity
        kdePackages.konversation
        moonlight-qt
        monero-gui
        picard
        telegram-desktop
        tor-browser
      ]
      ++ (with pkgs-stable; [
        calibre
        flacon
        rustdesk-flutter
        signal-desktop
      ]);
  };
}
