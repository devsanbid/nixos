{
  config,
  lib,
  pkgs,
  ...
}: let
  themePolarity = lib.removeSuffix "\n" (builtins.readFile (./. + "/themes/io/polarity.txt"));
  backgroundUrl = builtins.readFile (./. + "/themes/io/backgroundurl.txt");
  backgroundSha256 = builtins.readFile (./. + "/themes/io/backgroundsha256.txt");
in {
  home.username = "sanbid";
  home.homeDirectory = "/home/sanbid";
  home.stateVersion = "24.05";

  home.sessionPath = ["$HOME/.cargo/bin"];
  nixpkgs.config.allowUnfree = true;

  home.packages = with pkgs; [
    whatsapp-for-linux
    discord
    libsForQt5.qtstyleplugin-kvantum
    libsForQt5.qt5ct
    papirus-folders
    zafiro-icons
    webkitgtk
  ];


  stylix.autoEnable = true;
  stylix.enable = true;
  stylix.polarity = themePolarity;
  stylix.image = pkgs.fetchurl {
    url = backgroundUrl;
    sha256 = backgroundSha256;
  };
  stylix.base16Scheme = ./. + "/themes/io/io.yaml";

  ## cursor
  stylix.cursor = {
    package = pkgs.rose-pine-cursor;
    name = "BreezeX-RoséPine";
    size = 21;
  };

  stylix.targets.kde.enable = true;
  stylix.targets.gnome.enable = true;
  stylix.targets.gtk.enable = true;

  fonts.fontconfig.enable = true;

  services.wlsunset = {
    enable = true;
    latitude = "-22";
    longitude = "-43";
  };

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
    aliases = {};
  };

  programs.zathura.enable = true;

  programs.home-manager.enable = true;
}
