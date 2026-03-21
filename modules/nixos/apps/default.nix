# Apps — Docker, Flatpak, Podman/Distrobox, Waydroid
{ ... }:

{
  imports = [
    ./docker.nix
    ./distrobox.nix
    ./flatpak.nix
    ./waydroid.nix
  ];
}
