# Neovim — install + symlink multiple config directories
{ config, lib, pkgs, ... }:

let
  cfg = config.modules.home.dev.neovim;
in
{
  options.modules.home.dev.neovim = {
    enable = lib.mkEnableOption "Neovim editor configurations";
  };

  config = lib.mkIf cfg.enable {
    home.packages = with pkgs; [ neovim vim ];

    # Symlink all neovim config variants
    xdg.configFile = {
      "nvim" = {
        source = ../../../config/nvim;
        recursive = true;
        force = true;
      };
      "lazyvim" = {
        source = ../../../config/lazyvim;
        recursive = true;
        force = true;
      };
      "nixvim" = {
        source = ../../../config/nixvim;
        recursive = true;
        force = true;
      };
      "astro" = {
        source = ../../../config/astro;
        recursive = true;
        force = true;
      };
      "renew_nvim" = {
        source = ../../../config/renew_nvim;
        recursive = true;
        force = true;
      };
    };
  };
}
