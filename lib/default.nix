{ lib, ... }:
# Credits to https://github.com/EmergentMind and https://github.com/ryan4yin
{
  # Use path relative to the root of the project
  relativeToRoot = lib.path.append ../.;
}
