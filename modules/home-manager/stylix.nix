{
  stylix = {
    targets = {
      nixvim.enable = false;
      kitty = {
        # Kitty's colors are broken
        enable = true;
      };
      qt = {
        platform = "qtct";
      };
    };
  };
}
