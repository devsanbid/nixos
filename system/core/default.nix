# Core system modules
{ ... }: {
  imports = [
    ./boot.nix
    ./nix.nix
    ./locale.nix
  ];
}
