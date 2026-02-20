# Neovim — symlink multiple config directories
{ config, lib, pkgs, ... }:

let
  cfg = config.modules.home.dev.neovim;
in
{
  options.modules.home.dev.neovim = {
    enable = lib.mkEnableOption "Neovim editor configurations";
  };

  config = lib.mkIf cfg.enable {
    # Symlink all neovim config variants
    xdg.configFile = {
      "nvim" = {
        source = ../../../config/nvim;
        recursive = true;
      };
      "lazyvim" = {
        source = ../../../config/lazyvim;
        recursive = true;
      };
      "nixvim" = {
        source = ../../../config/nixvim;
        recursive = true;
      };
      "astro" = {
        source = ../../../config/astro;
        recursive = true;
      };
      "renew_nvim" = {
        source = ../../../config/renew_nvim;
        recursive = true;
      };
    };
  };
}
