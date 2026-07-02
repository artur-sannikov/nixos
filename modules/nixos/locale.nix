{
  flake.modules.nixos.locale = {
    i18n = {
      defaultLocale = "en_US.UTF-8";
      extraLocales = [
        "en_GB.UTF-8/UTF-8"
        "en_US.UTF-8/UTF-8"
        "fi_FI.UTF-8/UTF-8"
      ];
      extraLocaleSettings = {
        LC_TIME = "fi_FI.UTF-8";
      };
    };
  };
}
