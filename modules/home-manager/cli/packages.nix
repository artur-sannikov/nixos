{
  pkgs,
  pkgs-stable,
  # flake-inputs,
  ...
}:
{
  home.packages =
    with pkgs;
    [
      age
      ansible
      ansible-lint
      black
      beets
      caddy
      cloud-utils
      fd
      devenv
      distrobox
      gnumake
      isort
      jdk
      kubectl
      lynx
      mat2
      micromamba
      multiqc
      nextflow
      opentofu
      podlet
      python312Packages.huggingface-hub
      python312Packages.pip
      python312Packages.radian
      sass
      screen
      shellcheck
      shfmt
      sops
      talosctl
      terraform
      tesseract
      toolbox
      typst
      virtualenv
      wl-clipboard-rs
      yamlfmt
      yamllint
      # flake-inputs.flox.packages.${pkgs.system}.flox
    ]
    ++ (with pkgs-stable; [
      # quarto
    ]);
}
