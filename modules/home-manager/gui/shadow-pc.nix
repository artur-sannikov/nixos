{
  imports = [
    (
      fetchGit {
        url = "https://github.com/anthonyroussel/shadow-nix";
        rev = "2063ca3633f1630bd49a24b5eef49f0d747910c5";
      }
      + "/import/home-manager.nix"
    )
  ];

  programs.shadow-client = {
    enable = true;
    channel = "prod";
  };
}
