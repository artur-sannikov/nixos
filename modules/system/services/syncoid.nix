{ config, ... }:
{
  # Secrets
  sops = {
    secrets = {
      "keys/ssh/asus-syncoid-ssh-key" = { };
    };
  };
}
