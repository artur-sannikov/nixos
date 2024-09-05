{ pkgs, lib, ... }:

pkgs.stdenv.mkDerivation rec {
  pname = "duplicacy-web";
  version = "1.8.1";

  src = builtins.fetchurl {
    url = "https://acrosync.com/${pname}/duplicacy_web_linux_x64_${version}";
    sha256 = "5e0c8c940eeb378614e9b5d63f9dbff4ad8b8448a08f3803db141e9c653a767e";
  };
  doCheck = false;
  dontUnpack = true;

  installPhase = ''
    install -D $src $out/duplicacy-web
    chmod a+x $out/duplicacy-web
  '';

  meta = {
    homepage = "https://duplicacy.com";
    description = "A new generation cloud backup tool";
    platforms = lib.platforms.linux;
    license = lib.licenses.unfreeRedistributable;
  };
}
