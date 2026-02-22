# Apps — Docker, Flatpak, Podman/Distrobox
{ ... }:

{
  imports = [
    ./docker.nix
    ./distrobox.nix
    ./flatpak.nix
  ];
}
