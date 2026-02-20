# Apps — Docker, Flatpak, Podman/Distrobox, Virtualization
{ ... }:

{
  imports = [
    ./docker.nix
    ./distrobox.nix
    ./flatpak.nix
    ./virtualization.nix
  ];
}
