{ inputs, ... }:
{
  flake.modules.nixos.dms = {
    programs.dms-shell = {
      enable = true;
      systemd = {
        enable = true;
        restartIfChanged = true;
      };

      enableSystemMonitoring = true;
      enableVPN = true;
      enableDynamicTheming = true;
      enableAudioWavelength = true;
      enableCalendarEvents = true;
    };
  };
  flake.modules.homeManager.dms = {
    imports = [
      inputs.dms.homeModules.dank-material-shell
    ];
    programs.dank-material-shell = {
      enable = true;

      settings = {
        theme = "dark";
        dynamicTheming = true;
        # Add any other settings here
      };

      session = {
        isLightMode = false;
        # Add any other session state settings here
      };

      clipboardSettings = {
        maxHistory = 25;
        maxEntrySize = 5242880;
        autoClearDays = 1;
        clearAtStartup = true;
        disabled = false;
        disableHistory = false;
        disablePersist = true;
      };
    };
  };
}
