{
  flake.modules.nixos.zramswap = {
    zramSwap = {
      enable = true;
      algorithm = "zstd";
      memoryPercent = 30;
    };
  };
}
