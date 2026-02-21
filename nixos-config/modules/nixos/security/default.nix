# Security — SSH, automount
{ ... }:

{
  imports = [
    ./sshd.nix
    ./automount.nix
  ];
}
