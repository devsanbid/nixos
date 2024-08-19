{ config, pkgs, ... }:

{
  home.username = "sanbid";
  home.homeDirectory = "/home/sanbid";
  home.stateVersion = "24.05"; 

  home.packages = with pkgs; [
	hello
  ];

  home.file.".config/hypr".source = ./config/hypr;
  home.file.".config/nvim".source = ./config/nvim;
  home.file.".config/alacritty".source = ./config/alacritty;
  home.file.".config/kitty".source = ./config/kitty;
  home.file.".config/fish".source = ./config/fish;
  home.file.".config/dunst".source = ./config/dunst;
  home.file.".config/tmux".source = ./config/tmux;
  home.file.".config/vivid".source = ./config/vivid;
  home.file.".config/waybar".source = ./config/waybar;
  home.file.".config/pip".source = ./config/pip;
  home.file.".config/fuzzel".source = ./config/fuzzel;

  home.sessionVariables = {
    EDITOR = "nvim";
  };

  programs.git = {
  	enable = true;
	userName = "sandesh shahi";
	userEmail = "devsanbid@gmail.com";
	aliases = {
	};
  };

  programs.home-manager.enable = true;
}
