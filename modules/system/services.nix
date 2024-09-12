{
  services = {
    # Flatpak
    flatpak = {
      enable = true;
      update.onActivation = true;
      packages = [
        {
          appId = "us.zoom.Zoom";
          origin = "flathub";
          commit = "b9505f108b5f9acb2bbad83ac66f97b42bc6a75b9c28ed7b75dec1040e013305";
        } # Screen sharing is broken on Plasma on newer versions
      ];
    };
    # Prevent Intel CPU overheating
    thermald = {
      enable = true;
    };
    # Disable power-profiles-daemon to use TLP
    power-profiles-daemon = {
      enable = false;
    };
    # TLP - Optimize Linux Laptop Battery Life
    # ttps://linrunner.de/tlp/index.html
    tlp = {
      enable = true;
      settings = {

        # For all options see https://linrunner.de/tlp/settings/processor html
        CPU_SCALING_GOVERNOR_ON_AC = "performance";
        CPU_SCALING_GOVERNOR_ON_BAT = "powersave";
        CPU_ENERGY_PERF_POLICY_ON_BAT = "balance_power";
        CPU_ENERGY_PERF_POLICY_ON_AC = "performance";
        CPU_MIN_PERF_ON_AC = 0;
        CPU_MAX_PERF_ON_AC = 100;
        CPU_MIN_PERF_ON_BAT = 0;
        CPU_MAX_PERF_ON_BAT = 40;
        # Enable or disable Intel turbo boost
        CPU_BOOST_ON_AC = 1;
        CPU_BOOST_ON_BAT = 0;

        # For all options see https://linrunner.de/tlp/settings/battery.html
        START_CHARGE_THRESH_BAT0 = 40;
        STOP_CHARGE_THRESH_BAT0 = 80;

        # Exclude Bluetooth devices from autosuspend
        USB_EXCLUDE_BTUSB = 1;
      };
    };
    fwupd = {
      enable = true;
    };
  };
}
