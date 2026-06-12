{
  flake.modules.nixosModules.zramswap = {
    zramSwap = {
      enable = true;
      algorithm = "zstd";
      memoryPercent = 30;
    };
  };
}
