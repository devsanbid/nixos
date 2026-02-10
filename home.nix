{pkgs, ...}: {
imports = [
   # ./config/nixvim/init.nix
];
  home.username = "sanbid";
  home.homeDirectory = "/home/sanbid";
  home.stateVersion = "24.05";

  home.sessionPath = ["$HOME/.cargo/bin"];

  # DankMaterialShell - Modern Wayland Desktop Shell
  programs.dank-material-shell = {
    enable = true;
    # Using exec-once in Hyprland instead of systemd service
    # systemd.enable = true;
    # Settings managed via DMS GUI (don't use settings = {} to avoid overwriting)
  };

  # DankSearch - Filesystem search for DMS Spotlight
  programs.dsearch = {
    enable = true;
    config = {
      # Index common directories
      index_paths = [
        {
          path = "~";
          max_depth = 5;
          exclude_hidden = true;
          exclude_dirs = [ "node_modules" ".git" "target" "venv" ".cache" ".local" ".mozilla" ".config" "snap" "go" ];
        }
        {
          path = "~/.dotfiles";
          max_depth = 6;
          exclude_hidden = false;
          exclude_dirs = [ "result" ".git" ];
        }
        {
          path = "~/.config";
          max_depth = 4;
          exclude_hidden = true;
          exclude_dirs = [ "chromium" "BraveSoftware" "Code" "discord" ];
        }
      ];
    };
  };

  home.packages = with pkgs; [
    discord
    papirus-folders
    zafiro-icons
    rustc
    wf-recorder
    
    # OBS Studio with plugins for Hyprland/Wayland
    (wrapOBS {
      plugins = with obs-studio-plugins; [
        wlrobs                    # Wayland screen capture (wlroots/Hyprland)
        obs-pipewire-audio-capture  # PipeWire audio capture
        obs-vkcapture             # Vulkan/OpenGL game capture
        obs-vaapi                 # Hardware encoding (Intel/AMD)
      ];
    })
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
  # Use xdg.configFile with recursive to allow DMS to write theme files
  xdg.configFile."hypr" = {
    source = ./config/hyprland_2.0;
    recursive = true;
  };
  xdg.configFile."rofi" = {
    source = ./config/rofi;
    recursive = true;
  };
  xdg.configFile."ags" = {
    source = ./config/ags;
    recursive = true;
  };
  xdg.configFile."btop" = {
    source = ./config/btop;
    recursive = true;
  };
  xdg.configFile."cava" = {
    source = ./config/cava;
    recursive = true;
  };
  xdg.configFile."fastfetch" = {
    source = ./config/fastfetch;
    recursive = true;
  };
  xdg.configFile."qt5ct" = {
    source = ./config/qt5ct;
    recursive = true;
  };
  xdg.configFile."waybar" = {
    source = ./config/waybar;
    recursive = true;
  };
  xdg.configFile."qt6ct" = {
    source = ./config/qt6ct;
    recursive = true;
  };
  xdg.configFile."swappy" = {
    source = ./config/swappy;
    recursive = true;
  };
  xdg.configFile."swaync" = {
    source = ./config/swaync;
    recursive = true;
  };
  xdg.configFile."wlogout" = {
    source = ./config/wlogout;
    recursive = true;
  };
  xdg.configFile."wallust" = {
    source = ./config/wallust;
    recursive = true;
  };
  home.file."Pictures/wallpapers".source = ./config/wallpapers;
  # home.file.".config/nvim".source = ./config/lazyvim;
  xdg.configFile."alacritty" = {
    source = ./config/alacritty;
    recursive = true;
  };
  xdg.configFile."kitty" = {
    source = ./config/kitty;
    recursive = true;
  };
  xdg.configFile."fish" = {
    source = ./config/fish;
    recursive = true;
  };
  home.file.".config/fish/fish_variables".source = ./config/fish/fish_variables;
  xdg.configFile."dunst" = {
    source = ./config/dunst;
    recursive = true;
  };
  xdg.configFile."tmux" = {
    source = ./config/tmux;
    recursive = true;
  };
  xdg.configFile."vivid" = {
    source = ./config/vivid;
    recursive = true;
  };
  home.file.".zshrc".source = ./config/.zshrc;
  # home.file.".oh-my-zsh".source = ./config/.oh-my-zsh;
  xdg.configFile."pip" = {
    source = ./config/pip;
    recursive = true;
  };

  # GNOME Keyring - auto-unlock secrets with login password
  services.gnome-keyring = {
    enable = true;
    components = [ "pkcs11" "secrets" "ssh" ];
  };
  
  # Disable KDE Wallet via config
  home.file.".config/kwalletrc".text = ''
    [Wallet]
    Enabled=false
    First Use=false
  '';

  # Fuzzel - fast Wayland launcher (replaces anyrun due to D-Bus issues)
  programs.fuzzel = {
    enable = true;
    settings = {
      main = {
        font = "Hack Nerd Font:size=14";
        dpi-aware = "no";
        width = 35;
        horizontal-pad = 20;
        vertical-pad = 12;
        inner-pad = 8;
        lines = 10;
        letter-spacing = 0;
        layer = "overlay";
        terminal = "kitty -e";
        prompt = "❯ ";
        icons-enabled = "yes";
        icon-theme = "Papirus-Dark";
      };
      colors = {
        background = "1e1e2efa";
        text = "cdd6f4ff";
        match = "89b4faff";
        selection = "313244ff";
        selection-text = "cdd6f4ff";
        selection-match = "89b4faff";
        border = "89b4fa80";
      };
      border = {
        width = 2;
        radius = 16;
      };
    };
  };

  programs.git = {
    enable = true;
    userName = "devsanbid";
    userEmail = "devsanbid@gmail.com";
    aliases = {};
  };

  # programs.zathura.enable = true;

  programs.home-manager.enable = true;
}
