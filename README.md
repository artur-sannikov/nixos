# Artur's NixOS & Nix Home Manager configurations

<p align="center">
  <img src="https://img.shields.io/github/license/artur-sannikov/nixos" alt="License Badge"  height="20"/>
</p>

This repository contains NixOS configuration for my desktop, personal and work
laptops, and a small VM running on Proxmox
(for my [homelab](https://codeberg.org/arsann/homelab)). The configurations are based
on a [Nix flake](https://wiki.nixos.org/wiki/Flakes) for easy management and
configuration. Changes are made in `devel` branch and then merged into
`main` branch.

> [!NOTE]
>
> **System Information:**
>
> - **Desktop environment:** KDE Plasma 6
> - **File systems:** BTRFS/ZFS
> - **Shell:** zsh
> - **Terminal:** Alacritty
> - **Editors:** Nixvim/VSCodium

## Updates

Updates are managed via `flake.lock` on my own private Forgejo instance.
The workflows are
[public](https://codeberg.org/arsann/nixos/src/branch/main/.forgejo/workflows).

## Secrets

I keep secrets in a private repository and pull them into my configuration
with flake. EmergentMind wrote a
[great post](https://unmovedcentre.com/posts/secrets-management/) on how to
implement this.

## Configuration mirrors

This configuration is available on
[Codeberg](https://codeberg.org/arsann/nixos) and
[GitHub](https://github.com/artur-sannikov/nixos).
