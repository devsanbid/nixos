# Zsh — symlink existing config
{ config, lib, pkgs, ... }:

let
  cfg = config.modules.home.shell.zsh;
in
{
  options.modules.home.shell.zsh = {
    enable = lib.mkEnableOption "Zsh shell";
  };

  config = lib.mkIf cfg.enable {
    home.packages = with pkgs; [ zsh ];

    home.file.".zshrc" = {
      source = ../../../config/.zshrc;
      force = true;
    };
  };
}
