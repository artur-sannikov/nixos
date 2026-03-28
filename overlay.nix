final: prev: {
  iamb = prev.iamb.overrideAttrs (old: {
    patches = (old.patches or [ ]) ++ [
      (prev.fetchpatch {
        url = "https://raw.githubusercontent.com/NixOS/nixpkgs/6a8a32481c1bc5daf8438faf5836a4f25dbca7d6/pkgs/by-name/ia/iamb/0001-increase-recursion-limit-to-fix-matrix-sdk-sqlite.patch";
        hash = "sha256-MqRnm/SuEwfq01/pfYL24IZF3Sfy6RIrKdhtXoB1Vck=";
      })
    ];
  });
}
