{
  flake.modules.homeManager.mimetypes = {
    xdg.mimeApps = {
      enable = true;
      defaultApplications = {
        "application/pdf" = "org.kde.okular.desktop";
        "text/html" = "librewolf.desktop";
        "x-scheme-handler/http" = "librewolf.desktop";
        "x-scheme-handler/https" = "librewolf.desktop";
        "x-scheme-handler/about" = "librewolf.desktop";
        "x-scheme-handler/unknown" = "librewolf.desktop";
        "video/*" = "mpv.desktop";
      };
      # Required for Dolphin?
      associations.added = {
        "application/pdf" = "org.kde.okular.desktop";
        "video/*" = "mpv.desktop";
      };
    };
  };
  flake.modules.nixos.mimetypes =
    { pkgs, ... }:
    {
      # Make dolphin play nicely with mimeTypes
      # https://github.com/NixOS/nixpkgs/issues/409986#issuecomment-3217982330
      environment.etc."xdg/menus/applications.menu".source =
        "${pkgs.kdePackages.plasma-workspace}/etc/xdg/menus/plasma-applications.menu";
    };
}
