{ pkgs, lib, ... }:

{
  services.hardware.openrgb = {
    enable = true;
    package = pkgs.openrgb.overrideAttrs (old: {
      src = pkgs.fetchFromGitea {
        domain = "codeberg.org";
        owner = "OpenRGB";
        repo = "OpenRGB";
        rev = "release_candidate_1.0rc2";
        sha256 = "sha256-vdIA9i1ewcrfX5U7FkcRR+ISdH5uRi9fz9YU5IkPKJQ=";
      };
      # See patch discussion https://github.com/NixOS/nixpkgs/issues/446002
      patches = [
        ./remove_systemd_service.patch
      ];
      postPatch = ''
        patchShebangs scripts/build-udev-rules.sh
        substituteInPlace scripts/build-udev-rules.sh \
        --replace-fail /usr/bin/env "${pkgs.coreutils}/bin/env"
      '';
      version = "1.0rc2";
    });
    motherboard = "amd";
  };
  systemd.services.openrgb = lib.mkDefault {
    wantedBy = [ "multi-user.target" ];
    after = [
      "network.target"
      "lm_sensors.service"
    ];
    description = "OpenRGB SDK Server";
    serviceConfig = {
      RemainAfterExit = "yes";
      ExecStart = ''${pkgs.openrgb}/bin/openrgb --server'';
      Restart = "always";
    };
  };
}
