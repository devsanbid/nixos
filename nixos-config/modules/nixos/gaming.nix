# Gaming module — toggleable per-host
{ config, lib, pkgs, ... }:

let
  cfg = config.modules.gaming;
in
{
  options.modules.gaming = {
    enable = lib.mkEnableOption "Gaming packages (gamemode, heroic, lutris)";
  };

  config = lib.mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      bubblewrap
      gamemode
      heroic
      lutris
      warehouse
    ];
  };
}
