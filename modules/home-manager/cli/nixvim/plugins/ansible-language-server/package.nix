# https://git.notthebe.ee/notthebee/nix-config/src/branch/main/modules/dots/nvim/ansible-language-server/package.nix
{ pkgs }:
let
  # Updates pretty fast
  yarnLock = builtins.fetchurl {
    url = "https://raw.githubusercontent.com/ansible/vscode-ansible/refs/heads/main/yarn.lock";
    sha256 = "16b37nr0i0p2bgp1kznkrbr0r060p4jzw26iw5crpapnhgnv7946";
  };
in
pkgs.stdenv.mkDerivation rec {
  pname = "ansible-language-server";
  version = "26.1.3";
  src = pkgs.fetchFromGitHub {
    owner = "ansible";
    repo = "vscode-ansible";
    tag = "v${version}";
    hash = "sha256-DsEW3xP8Fa9nwPuyEFVqG6rvAZgr4TDB6jhyixdvqt8=";
  };
  buildInputs = [
    pkgs.nodejs
    pkgs.corepack
    pkgs.yarn
    pkgs.cacert
  ];
  buildPhase = ''
    export HOME=$(pwd)
    yarn install --immutable
    yarn run compile
  '';
  postPatch = ''
    # cp ${./yarn.lock} yarn.lock
    if [ -f .yarnrc.yml ]; then
      sed -i '/yarnPath:/d' .yarnrc.yml
    fi
  '';
  installPhase = ''
    mkdir -p $out
    cp -r packages/ansible-language-server/* $out/
    cp -r out/* $out/out
    rm -rf node_modules/@ansible
    cp -r node_modules/* $out/node_modules
  '';
  meta.mainProgram = "ansible-language-server";
}
