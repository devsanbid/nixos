{pkgs, ...}: {
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

  stylix = {
    enable = true;

    # See https://tinted-theming.github.io/tinted-gallery/ for more schemes
    base16Scheme = {
      base00 = "0c0e0f"; # Default Background
      base01 = "101314"; # Lighter Background (Used for status bars, line number and folding marks)
      base02 = "313244"; # Selection Background
      base03 = "45475a"; # Comments, Invisibles, Line Highlighting
      base04 = "585b70"; # Dark Foreground (Used for status bars)
      base05 = "cdd6f4"; # Default Foreground, Caret, Delimiters, Operators
      base06 = "f5e0dc"; # Light Foreground (Not often used)
      base07 = "b4befe"; # Light Background (Not often used)
      base08 = "f38ba8"; # Variables, XML Tags, Markup Link Text, Markup Lists, Diff Deleted
      base09 = "fab387"; # Integers, Boolean, Constants, XML Attributes, Markup Link Url
      base0A = "f9e2af"; # Classes, Markup Bold, Search Text Background
      base0B = "a6e3a1"; # Strings, Inherited Class, Markup Code, Diff Inserted
      base0C = "94e2d5"; # Support, Regular Expressions, Escape Characters, Markup Quotes
      base0D = "89b4fa"; # Functions, Methods, Attribute IDs, Headings, Accent color
      base0E = "cba6f7"; # Keywords, Storage, Selector, Markup Italic, Diff Changed
      base0F = "f2cdcd"; # Deprecated, Opening/Closing Embedded Language Tags, e.g. <?php ?>
    };

    cursor = {
      package = pkgs.bibata-cursors;
      name = "Bibata-Modern-Ice";
      size = 24;
    };

    fonts = {
      monospace = {
        package = pkgs.nerd-fonts.jetbrains-mono;
        name = "JetBrains Mono Nerd Font";
      };
      sansSerif = {
        package = pkgs.nerd-fonts.jetbrains-mono;
        name = "JetBrains Mono Nerd Font";
      };
      serif = {
        package = pkgs.nerd-fonts.jetbrains-mono;
        name = "JetBrains Mono Nerd Font";
      };
      emoji = {
        package = pkgs.noto-fonts-emoji;
        name = "Noto Color Emoji";
      };
      sizes = {
        applications = 13;
        desktop = 13;
        popups = 13;
        terminal = 13;
      };
    };

    polarity = "dark";
    image = pkgs.fetchurl {
      url =
        "https://github.com/anotherhadi/nixy-wallpapers/blob/main/wallpapers/"
        + "a-lake-surrounded-by-mountains.png"
        + "?raw=true";
      sha256 = "sha256-5VHprxEVOkqyecnsurUx1tmhwE+3v0dhwmhpBPDTOgU=";
    };
  };

  ## style theme ###
  # stylix = {
  #   enable = true;
  #
  #   ## theme ##
  #   base16Scheme = "${pkgs.base16-schemes}/share/themes/tokyo-night-dark.yaml";
  #
  #   ## perfer color mode ##
  #   polarity = "dark";
  # };
  #
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

  home.file.".config/hypr".source = ./config/hyprland_2.0;
  home.file.".config/rofi".source = ./config/rofi;
  home.file.".config/ags".source = ./config/ags;
  home.file.".config/btop".source = ./config/btop;
  home.file.".config/cava".source = ./config/cava;
  home.file.".config/fastfetch".source = ./config/fastfetch;
  home.file.".config/qt5ct".source = ./config/qt5ct;
  home.file.".config/qt6ct".source = ./config/qt6ct;
  home.file.".config/swappy".source = ./config/swappy;
  home.file.".config/swaync".source = ./config/swaync;
  home.file.".config/wlogout".source = ./config/wlogout;
  home.file.".config/wallust".source = ./config/wallust;
  home.file."Pictures/wallpapers".source = ./config/wallpapers;
  home.file.".config/nvim".source = ./config/nvim;
  home.file.".config/alacritty".source = ./config/alacritty;
  home.file.".config/kitty".source = ./config/kitty;
  home.file.".config/fish".source = ./config/fish;
  home.file.".config/fish/fish_variables".source = ./config/fish/fish_variables;
  home.file.".config/dunst".source = ./config/dunst;
  home.file.".config/tmux".source = ./config/tmux;
  home.file.".config/vivid".source = ./config/vivid;
  home.file.".zshrc".source = ./config/.zshrc;
  home.file.".oh-my-zsh".source = ./config/.oh-my-zsh;
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
