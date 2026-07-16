{
  flake.modules.nixvim.default = {
    plugins = {
      no-neck-pain = {
        enable = false;
        settings = {
          width = 150;
          autocmds = {
            # Not really needed on Niri since I can center the current column
            enableOnVimEnter = false; # It enter when I open a buffer
            enableOnTabEnter = true;
            skipEnteringNoNeckPainBuffer = true;
          };
          mappings = {
            enabled = true;
          };
          # Integrate with snacks
          # Supported dashboards here:
          integrations.dashboard.enabled = true;
        };
      };
    };
  };
}
