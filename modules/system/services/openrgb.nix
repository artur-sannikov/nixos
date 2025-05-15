{ pkgs, flake-inputs, ... }:

{
  services.hardware.openrgb = {
    enable = true;
    package = pkgs.openrgb.overrideAttrs {
      version = "experimental";
      src = flake-inputs.openrgb-experimental;
      postPatch = ''
        patchShebangs scripts/build-udev-rules.sh
        substituteInPlace scripts/build-udev-rules.sh \
          --replace "/usr/bin/env chmod" "${pkgs.coreutils}/bin/chmod"
      '';
    };
    motherboard = "amd";
  };
}
