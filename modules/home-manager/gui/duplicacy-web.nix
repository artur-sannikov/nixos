{ pkgs, lib, ... }:

pkgs.stdenv.mkDerivation rec {
  pname = "duplicacy-web";
  version = "1.8.2";

  src = builtins.fetchurl {
    url = "https://acrosync.com/${pname}/duplicacy_web_linux_x64_${version}";
    sha256 = "1binx4mx08nycykxvd5jvy7ll2jk73cd8jdmrsndx5xvrhlh8hb1";
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
