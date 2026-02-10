{ ... }: {
  imports = [
    ./docker.nix
    ./distrobox.nix
    ./flatpak.nix
    ./virtualization.nix
  ];
}

