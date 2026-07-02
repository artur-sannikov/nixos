{
  flake.modules.homeManager.gui = { pkgs, ... }: {
    home = {
      packages = with pkgs.stable; [
        mullvad-browser
      ];
    };
  };
}
