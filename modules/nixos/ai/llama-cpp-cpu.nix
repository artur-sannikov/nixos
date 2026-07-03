{
  flake.modules.nixos.llama-cpu = { pkgs, ... }: {
    services = {
      llama-cpp = {
        enable = true;
        package = pkgs.llama-cpp;
        settings = {
          models-preset = (pkgs.formats.ini { }).generate "models-preset.ini" {
            "gemma-4-E2B" = {
              hf-repo = "mradermacher/gemma-4-E2B-GGUF";
              hf-file = "gemma-4-E2B.IQ4_XS.gguf";
              alias = "gemma-4-E2B.Q4_K_S.gguf";
              temp = "1.0";
              top-p = "0.95";
              top-k = "64";
            };
          };
        };
      };
    };
  };
}
