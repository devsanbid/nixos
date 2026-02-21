# Tmux — symlink existing config
{ config, lib, pkgs, ... }:

let
  cfg = config.modules.home.shell.tmux;
in
{
  options.modules.home.shell.tmux = {
    enable = lib.mkEnableOption "Tmux terminal multiplexer";
  };

  config = lib.mkIf cfg.enable {
    home.packages = with pkgs; [ tmux ];

    xdg.configFile."tmux/tmux.conf" = {
      source = ../../../config/tmux/tmux.conf;
      force = true;
    };
  };
}
