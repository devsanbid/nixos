# Security — SSH, firewall, automount
{ ... }:

{
  imports = [
    ./sshd.nix
    ./firewall.nix
    ./automount.nix
  ];
}
