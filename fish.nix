{ config, pkgs, ... }: {
  programs.fish.enable = true;
  home.file.".config/fish".source = ./config/fish;
}
