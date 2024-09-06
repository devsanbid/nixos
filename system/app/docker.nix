{ pkgs, lib, ... }:

{
  virtualisation.docker = {
    enable = true;
    enableOnBoot = true;
    autoPrune.enable = true;
  };
  users.users."sanbid".extraGroups = [ "docker" ];
  environment.systemPackages = with pkgs; [
    docker
    docker-compose
  ];
}
