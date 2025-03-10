{ pkgs, lib, ... }:

pkgs.stdenv.mkDerivation rec {
  pname = "duplicacy-web";
  version = "1.8.3";

  src = builtins.fetchurl {
    url = "https://acrosync.com/${pname}/duplicacy_web_linux_x64_${version}";
    sha256 = "1y3yvnk1nlfwpnx8g7y8jbzw7crz2fjz67cljg7hzz75ba3smp4w";
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
