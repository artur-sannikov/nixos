{ pkgs, ... }:
{
  programs.nixvim.plugins = {
    yarepl = {
      package = pkgs.vimUtils.buildVimPlugin rec {
        pname = "yarepl.nvim";
        version = "0.11.0";
        src = pkgs.fetchFromGithub {
          owner = "milanglacier";
          repo = "yarepl.nvim";
          rev = "v${version}";
          hash = "";
        };
      };
    };
  };
}
