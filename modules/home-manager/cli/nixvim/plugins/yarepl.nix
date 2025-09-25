{ pkgs, ... }:
{
  programs.nixvim.extraPlugins = [
    (pkgs.vimUtils.buildVimPlugin rec {
      pname = "yarepl.nvim";
      version = "0.11.0";
      src = pkgs.fetchFromGitHub {
        owner = "milanglacier";
        repo = "${pname}";
        rev = "v${version}";
        hash = "sha256-6kl7xQpDiyuiqmjTPVbAjff+EGIVzWw/RBOaqZP3iGo=";
      };
      # I use telescope
      nvimSkipModules = [ "yarepl.extensions.fzf" ];
    })
  ];
}
