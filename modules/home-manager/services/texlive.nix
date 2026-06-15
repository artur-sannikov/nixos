{
  flake.modules.homeManager.gui = {
    programs = {
      texlive = {
        enable = true;
        # extraPackages = tpkgs: {
        #   inherit (tpkgs)
        #     scheme-medium
        #     wrapfig
        #     ;
        # };
      };
    };
  };
}
