# This is for laptops
{
  flake.modules.nixos.timezone-dynamic = {
    services = {
      automatic-timezoned = {
        enable = true;
      };
      geoclue2 = {
        geoProviderUrl = "https://api.beacondb.net/v1/geolocate";
      };
    };
  };
}
