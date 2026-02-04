# Artur's NixOS & Nix Home Manager configurations

<p align="center">
  <img
    src="https://img.shields.io/badge/License-MIT-yellow.svg"
    alt="License Badge"
    height="20"
  />
</p>

This repository contains NixOS configuration for my desktop, personal and work
laptops, and a small VM running on Proxmox (for my
[homelab](https://codeberg.org/arsann/homelab)). The configurations are based
on a [Nix flake](https://wiki.nixos.org/wiki/Flakes) for easy management and
configuration. Changes are made in `devel` branch and then merged into `main`
branch.

> [!NOTE]
>
> **System Information:**
>
> - **Desktop environment:** KDE Plasma 6
> - **File systems:** BTRFS/ZFS
> - **Shell:** zsh
> - **Terminal:** Kitty
> - **Editor:** Nixvim

## Updates

Updates are managed via `flake.lock` on my own private Forgejo instance.
The workflows are
[public](https://codeberg.org/arsann/nixos/src/branch/main/.forgejo/workflows).

## Secrets

I keep secrets in a private repository and pull them into my configuration
with flake. EmergentMind wrote a
[great post](https://unmovedcentre.com/posts/secrets-management/) on how to
implement this.

## Stuff to do manually

Not everything is feasible (still?) to declare. Not an exhaustive list of stuff
to do after the installation:

- Login into Librewolf for syncing
- Login into `gh`
- Login into `bw`
- Set up config file for `vdirsyncer` in `.config/vdirsyncer`
- Set up Thunderbird if it asks for password
- Set up `tailscale`

## Configuration mirrors

This configuration is available on
[Codeberg](https://codeberg.org/arsann/nixos) and
[GitHub](https://github.com/artur-sannikov/nixos).
