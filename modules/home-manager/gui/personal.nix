{ inputs, ... }:
{
  # Personal apps
  flake.modules.homeManager.gui-personal = { pkgs, ... }: {
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
        signal-desktop
        rustdesk-flutter
        telegram-desktop
        tor-browser
      ]
      ++ (with pkgs.stable; [
        calibre
        flacon
      ]);
  };
}
