# Podman + Distrobox
{ pkgs, ... }:

{
  virtualisation.podman = {
    enable = true;
    dockerCompat = false;
    defaultNetwork.settings.dns_enabled = true;
  };

  environment.systemPackages = with pkgs; [
    distrobox
    podman
    podman-compose
    xorg.xhost
  ];

  users.users."sanbid".extraGroups = [ "podman" ];
}
