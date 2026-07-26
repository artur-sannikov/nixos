{ inputs, ... }:
{
  flake.modules.nixos = {
    server = { pkgs, lib, ... }: {
      imports = with inputs.self.modules.nixos; [
        base
        openssh
        timezone-static
      ];
      programs.zsh.enable = lib.mkForce false; # Disable zsh on servers
      users.users.artur.shell = lib.mkForce pkgs.bash; # Force user on server to have bash
    };
  };
}
