#!/usr/bin/env bash

set -e

# Check if NIXOS_ANYWHERE_HOST is set
if [[ -z "${NIXOS_ANYWHERE_HOST}" ]]; then
    echo "NIXOS_ANYWHERE_HOST is not set!"
    exit 1
else
    echo "NIXOS_ANYWHERE_HOST variable is set to ${NIXOS_ANYWHERE_HOST}"
fi

# Create a temporary directory
temp=$(mktemp -d)

# Function to cleanup temporary directory on exit
cleanup() {
    rm -rf "$temp"
}
trap cleanup EXIT

# Create the directory where sshd expects to find the host keys
install -d -m755 "$temp/etc/ssh"

# Decrypt your private key from the password store and copy it to the temporary directory
pass nixos_anywhere_ed25519_hostkey >"$temp/etc/ssh/ssh_host_ed25519_key"

# Set the correct permissions so sshd will accept the key
chmod 600 "$temp/etc/ssh/ssh_host_ed25519_key"

# Install NixOS to the host system with our secrets
nix run github:nix-community/nixos-anywhere -- --extra-files "$temp" \
    --flake ".#${NIXOS_ANYWHERE_HOST}" \
    --ssh-option "PubkeyAuthentication=no" \
    --target-host root@"${NIXOS_ANYWHERE_HOST}"
