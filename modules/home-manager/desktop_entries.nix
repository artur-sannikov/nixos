{
  xdg.desktopEntries.obsidian = {
    name = "obsidian";
    type = "Application";
    comment = "Knowledge base";
    categories = [ "Office" ];
    exec = "obsidian --ozone-platform=wayland %u";
    icon = "obsidian";
    mimeType = [ "x-scheme-handler/obsidian" ];
    settings = {
      Version = "1.4";
    };
  };
}
