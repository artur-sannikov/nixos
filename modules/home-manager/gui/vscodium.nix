{
  pkgs-unstable,
  pkgs,
  flake-inputs,
  ...
}:
{
  programs.vscode = {
    enable = true;
    package = pkgs-unstable.vscodium;
    extensions =
      with pkgs.vscode-marketplace;
      [
        catppuccin.catppuccin-vsc-icons
        jnoortheen.nix-ide
        mkhl.direnv
        ms-python.python
        myriad-dreamin.tinymist
        quarto.quarto
        redhat.ansible
        redhat.vscode-yaml
        reditorsupport.r
      ]
      ++ [
        (pkgs.catppuccin-vsc.override {
          # These settings are not applied
          # They are default
          accent = "mauve";
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
    userSettings = {
      # Font settings
      "editor.fontFamily" = "'Iosevka Medium Extended', monospace";
      "editor.fontLigatures" = true;
      "editor.fontSize" = 14;
      # Enable smooth scrolling
      "editor.smoothScrolling" = true;
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
      "catppuccin.accentColor" = "green";
      "catppuccin.italicKeywords" = false;
      "catpuccin.boldKeywords" = false;
    };
  };
}
