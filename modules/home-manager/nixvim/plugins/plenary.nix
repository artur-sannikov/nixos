{
  flake.modules.nixvim.default =
    { pkgs, ... }:
    {
      extraPlugins = with pkgs.vimPlugins; [
        plenary-nvim
      ];
    };
}
