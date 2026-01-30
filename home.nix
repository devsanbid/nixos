{pkgs, ...}: {
imports = [
   # ./config/nixvim/init.nix
];
  home.username = "sanbid";
  home.homeDirectory = "/home/sanbid";
  home.stateVersion = "24.05";

  home.sessionPath = ["$HOME/.cargo/bin"];

  home.packages = with pkgs; [
    discord
    papirus-folders
    zafiro-icons
    rustc
    wf-recorder
  ];

  home.sessionVariables = {};

  xdg.desktopEntries = {
    netbeans = {
      name = "netbeans 2";
      icon = "netbeans";
      genericName = "Integrated Development Environment";
      exec = "netbeans --fontsize 24";
      categories = ["Development"];
    };
  };

  # home.file.".config/hypr".source = ./config/hyprland_2.0;
  home.file.".config/rofi".source = ./config/rofi;
  home.file.".config/ags".source = ./config/ags;
  home.file.".config/btop".source = ./config/btop;
  home.file.".config/cava".source = ./config/cava;
  home.file.".config/fastfetch".source = ./config/fastfetch;
  home.file.".config/qt5ct".source = ./config/qt5ct;
  home.file.".config/waybar".source = ./config/waybar;
  home.file.".config/qt6ct".source = ./config/qt6ct;
  home.file.".config/swappy".source = ./config/swappy;
  home.file.".config/swaync".source = ./config/swaync;
  home.file.".config/wlogout".source = ./config/wlogout;
  home.file.".config/wallust".source = ./config/wallust;
  home.file."Pictures/wallpapers".source = ./config/wallpapers;
  # home.file.".config/nvim".source = ./config/lazyvim;
  home.file.".config/alacritty".source = ./config/alacritty;
  home.file.".config/kitty".source = ./config/kitty;
  home.file.".config/fish".source = ./config/fish;
  home.file.".config/fish/fish_variables".source = ./config/fish/fish_variables;
  home.file.".config/dunst".source = ./config/dunst;
  home.file.".config/tmux".source = ./config/tmux;
  home.file.".config/vivid".source = ./config/vivid;
  home.file.".zshrc".source = ./config/.zshrc;
  # home.file.".oh-my-zsh".source = ./config/.oh-my-zsh;
  home.file.".config/pip".source = ./config/pip;
  home.file.".config/fuzzel".source = ./config/fuzzel;

  services.gnome-keyring.enable = true;

  programs.git = {
    enable = true;
    userName = "devsanbid";
    userEmail = "devsanbid@gmail.com";
    aliases = {};
  };

  # programs.zathura.enable = true;

  programs.home-manager.enable = true;
}
