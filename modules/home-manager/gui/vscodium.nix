{
  pkgs,
  pkgs-unstable,
  lib,
  flake-inputs,
  ...
}:
{
  stylix.targets = {
    vscode.enable = false;
  };
  programs.vscode = {
    enable = true;
    package = pkgs-unstable.vscodium;
    mutableExtensionsDir = false;
    extensions =
      with pkgs.vscode-extensions;
      [
        davidanson.vscode-markdownlint
        catppuccin.catppuccin-vsc-icons
        jnoortheen.nix-ide
        matthewpi.caddyfile-support
        mkhl.direnv
        ms-python.python
        ms-vscode-remote.remote-containers
        myriad-dreamin.tinymist
        redhat.ansible
        redhat.vscode-yaml
        reditorsupport.r
      ]
      ++ (with flake-inputs.nix-vscode-extensions.extensions.${pkgs.system}.vscode-marketplace; [
        ipierre1.ansible-vault-vscode
        quarto.quarto
      ])
      ++ (with flake-inputs.nix-vscode-extensions.extensions.${pkgs.system}.open-vsx; [
        jeanp413.open-remote-ssh
      ])
      ++ [
        (pkgs.catppuccin-vsc.override {
          accent = "blue";
          boldKeywords = true;
          italicComments = false;
          italicKeywords = false;
          extraBordersEnabled = false;
          workbenchMode = "default";
          bracketMode = "rainbow";
          colorOverrides = { };
          customUIColors = { };
        })
      ];
    keybindings = [
      # Insert assignment operator if code is R
      {
        key = "alt+-";
        command = "type";
        when = "editorLangId == r && editorTextFocus || editorLangId == quarto && editorTextFocus || editorLangId == rmd && editorTextFocus";
        args = {
          text = " <- ";
        };
      }
      # Insert new R code chunk
      {
        key = "ctrl+alt+i";
        command = "type";
        when = "editorLangId == r && editorTextFocus || editorLangId == quarto && editorTextFocus || editorLangId == rmd && editorTextFocus";
        args = {
          text = "```{r}\n\n```\n";
        };
      }
    ];
    userSettings = lib.mkDefault {
      # Font settings
      "editor.fontFamily" = "'Iosevka Medium Extended', monospace";
      "editor.fontLigatures" = true;
      "editor.fontSize" = 14;
      # Enable smooth scrolling
      "editor.smoothScrolling" = true;

      # Recommendation from https://github.com/catppuccin/vscode
      "editor.semanticHighlighting.enabled" = true;
      "terminal.integrated.minimumContrastRatio" = 1;
      "window.titleBarStyle" = "custom";
      # Format on save
      "editor.formatOnSave" = true;
      # nix configuration
      "nix.enableLanguageServer" = true;
      "nix.serverPath" = "nixd";
      "nix.serverSettings" = {
        "nixd" = {
          "formatting" = {
            "command" = [ "nixfmt" ];
          };
        };
      };
      "files.associations" = {
        "*.hujson" = "jsonc";
        "*.bu" = "yaml";
        "main.yml" = "ansible";
      };
      "git.autofetch" = true;
      # Set default shell to zsh
      "terminal.integrated.defaultProfile.linux" = "zsh";
      # Remove traling whitespace on save
      "files.trimTrailingWhitespace" = true;
      # Disable RedHat telemetry
      "redhat.telemetry.enabled" = false;
      # Apply Catppuccin theme
      "workbench.colorTheme" = "Catppuccin Mocha";
      "workbench.iconTheme" = "catppuccin-macchiato";

      "window.newWindowDimensions" = "maximized";

      # Dev containers backend
      "dev.containers.dockerPath" = "podman";
    };
  };
}
