{ config, ... }:
{
  programs = {
    zsh = {
      sessionVariables = {
        PASSWORD_STORE_DIR = "${config.xdg.dataHome}/.password-store";
      };
    };
    password-store = {
      enable = true;
      settings = {
        PASSWORD_STORE_DIR = "${config.xdg.dataHome}/.password-store";
      };
    };
  };
}
