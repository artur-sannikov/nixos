{ inputs, ... }:
{
  # Work apps
  flake.modules.homeManager.gui-work =
    {
      pkgs,
      pkgs-stable,
      ...
    }:
    {
      imports = with inputs.self.modules.homeManager; [
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
