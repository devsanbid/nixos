{ config, pkgs, ... }:
{
  imports = [
    ./fish.nix
  ];
  home.username = "sanbid";
  home.homeDirectory = "/home/sanbid";
  home.stateVersion = "24.05";

  home.sessionPath = [ "$HOME/.cargo/bin" ];
  nixpkgs.config.allowUnfree = true;

  home.packages = with pkgs; [
    whatsapp-for-linux
    discord
    (catppuccin-kvantum.override {
      accent = "Blue";
      variant = "Macchiato";
    })
    libsForQt5.qtstyleplugin-kvantum
    libsForQt5.qt5ct
    papirus-folders
    zafiro-icons
  ];


  qt = {
    enable = true;
    platformTheme.name = "gtk2";
  };

  fonts.fontconfig.enable = true;

  xdg.configFile."Kvantum/kvantum.kvconfig".source = (pkgs.formats.ini { }).generate "kvantum.kvconfig" {
    General.theme = "Catppuccin-Macchiato-Blue";
  };

  services.wlsunset = {
    enable = true;
    latitude = "-22";
    longitude = "-43";
  };

  home.file.".config/hypr".source = ./config/hypr;
  home.file.".config/nvim".source = ./config/nvim;
  home.file.".config/alacritty".source = ./config/alacritty;
  home.file.".config/kitty".source = ./config/kitty;
  home.file.".config/dunst".source = ./config/dunst;
  home.file.".config/tmux".source = ./config/tmux;
  home.file.".config/vivid".source = ./config/vivid;
  home.file.".config/waybar".source = ./config/waybar;
  home.file.".config/pip".source = ./config/pip;
  home.file.".config/fuzzel".source = ./config/fuzzel;

  home.sessionVariables = {
    EDITOR = "nvim";
    NIXOS_OZONE_WL = 1;
    MOZ_ENABLE_WAYLAND = 1;
    GDK_BACKEND = "wayland,x11";
    QT_QPA_PLATFORM = "wayland-egl";
    SDL_VIDEODRIVER = "wayland";
    CLUTTER_BACKEND = "wayland";
    XDG_SESSION_TYPE = "wayland";
  };

  services.gnome-keyring.enable = true;

  programs.git = {
    enable = true;
    userName = "devsanbid";
    userEmail = "devsanbid@gmail.com";
    aliases = { };
  };

  programs.zathura.enable = true;

  programs.home-manager.enable = true;
}
