{ inputs, ... }:
{
  # Work apps
  flake.modules.homeModules.work =
    {
      pkgs,
      pkgs-stable,
      ...
    }:
    {
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
