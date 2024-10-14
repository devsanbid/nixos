{ config, lib, pkgs, nix-colors, ... }:

{
  imports =
    [
      ./hardware-configuration.nix
      ./system
    ];


  boot.loader = {
    efi = {
      canTouchEfiVariables = true;
      efiSysMountPoint = "/boot/efi"; # ← use the same mount point here.
    };
    grub = {
      efiSupport = true;
      #efiInstallAsRemovable = true; # in case canTouchEfiVariables doesn't work for your system
      device = "nodev";
    };
  };

  systemd = {
    user.services.polkit-gnome-authentication-agent-1 = {
      description = "polkit-gnome-authentication-agent-1";
      wantedBy = [ "graphical-session.target" ];
      wants = [ "graphical-session.target" ];
      after = [ "graphical-session.target" ];
      serviceConfig = {
        Type = "simple";
        ExecStart = "${pkgs.polkit_gnome}/libexec/polkit-gnome-authentication-agent-1";
        Restart = "on-failure";
        RestartSec = 1;
        TimeoutStopSec = 10;
      };
    };
  };

  system.autoUpgrade = {
    enable = true;
    operation = "switch"; # If you don't want to apply updates immediately, only after rebooting, use `boot` option in this case
    flake = "/home/sanbid/.dotfiles";
    flags = [ "--update-input" "nixpkgs" "--update-input" "rust-overlay" "--commit-lock-file" ];
    dates = "weekly";
  };

  networking.hostName = "nixos";

  # Enable networking
  networking = {
    networkmanager = {
      enable = true;
    };
  };


  # Set your time zone.
  time.timeZone = "Asia/Kathmandu";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

  # Configure keymap in X11
  services.xserver.xkb = {
    layout = "us";
    variant = "";
  };

  # Enable CUPS to print documents.
  services.printing.enable = true;

  # Enable sound with pipewire.
  hardware.pulseaudio.enable = false;
  security = {
    sudo.extraConfig = "sanbid ALL=(ALL:ALL) SETENV: ALL";
    rtkit.enable = true;
    polkit.enable = true;
  };


  users.users.sanbid = {
    isNormalUser = true;
    description = "sanbid";
    extraGroups = [ "networkmanager" "libvirtd" "docker" "wheel" "ydotool" ];
    packages = with pkgs; [
    ];
  };

  nix.settings.auto-optimise-store = true;
  nix.optimise.automatic = true;

  nix.gc = {
    automatic = true;
    persistent = true;
    dates = "weekly";
    options = "--delete-older-than 7d";
  };

  # Enable Gnome
  services.xserver.enable = true;
  services.xserver.displayManager.gdm.enable = true;
  services.xserver.desktopManager.gnome.enable = true;

  #Java
  nixpkgs.config.allowUnfree = true;

  # Install firefox.
  programs = {
    firefox.enable = true;
    fish.enable = true;
    appimage.enable = true;
    java.enable = true;
    ydotool = {
      enable = true;
    };
  };

  programs.nix-ld.enable = true;
  programs.nix-ld.libraries = with pkgs; [
  ];

  services.dbus = {
    enable = true;
    implementation = "broker";
    packages = with pkgs; [
      xfce.xfconf
      gnome2.GConf
    ];
  };


  services.gvfs.enable = true;
  environment.variables.GTK_THEME = "catppuccin-macchiato-teal-standard";
  environment.variables.XCURSOR_THEME = "Catppuccin-Macchiato-Teal";
  environment.variables.HYPRCURSOR_THEME = "Catppuccin-Macchiato-Teal";
  environment.variables.HYPRCURSOR_SIZE = "24";
  qt.enable = true;
  qt.platformTheme = "gtk2";
  qt.style = "gtk2";
  console = {
    earlySetup = true;
    colors = [
      "24273a"
      "ed8796"
      "a6da95"
      "eed49f"
      "8aadf4"
      "f5bde6"
      "8bd5ca"
      "cad3f5"
      "5b6078"
      "ed8796"
      "a6da95"
      "eed49f"
      "8aadf4"
      "f5bde6"
      "8bd5ca"
      "a5adcb"
    ];
  };

  # Override packages
  nixpkgs.config.packageOverrides = pkgs: {
    colloid-icon-theme = pkgs.colloid-icon-theme.override { colorVariants = [ "teal" ]; };
    catppuccin-gtk = pkgs.catppuccin-gtk.override {
      accents = [ "teal" ]; # You can specify multiple accents here to output multiple themes 
      size = "standard";
      variant = "macchiato";
    };
    discord = pkgs.discord.override {
      withOpenASAR = true;
      withTTS = true;
    };
  };




  #default shell
  users.defaultUserShell = pkgs.fish;
  environment.systemPackages = with pkgs; [
    wget
    isoimagewriter
    python312Packages.pynvim
    vim
    wlogout
    wlrctl
    wtype
    xdg-utils

    wl-clip-persist
    cliphist
    wl-screenrec
    imagemagick
    swappy
    ffmpeg_6-full
    at-spi2-atk
    qt6.qtwayland
    sway

    psi-notify
    poweralertd
    playerctl
    psmisc
    numix-icon-theme-circle
    colloid-icon-theme
    catppuccin-gtk
    catppuccin-kvantum
    catppuccin-cursors.macchiatoTeal
    neovim
    hyprpicker
    hyprcursor
    hyprlock
    hypridle
    cool-retro-term
    imv
    onefetch
    sumneko-lua-language-server
    hyprls
    emmet-language-server
    nil
    hyprpaper
    htop
    mycli
    jdk
    python312Packages.python-dotenv
    micromamba
    grimblast
    libinput-gestures
    rust-analyzer
    python312Packages.pyautogui
    wgnord
    comic-mono
    wmctrl
    moreutils
    obs-studio
    obs-cli
    openssl
    pkg-config
    kotatogram-desktop
    brave
    kitty
    git
    dunst
    alacritty
    mysql-workbench
    gtk4
    bun
    tmux
    python312Packages.pip
    vivid
    waybar
    wpaperd
    starship
    rustup
    ripgrep
    python312Packages.huggingface-hub
    fd
    dua
    stow
    ansible
    wofi
    brightnessctl
    bat
    bc
    dolphin
    kdePackages.dolphin-plugins
    dog
    fastfetch
    fzf
    gvfs
    gzip
    unzip
    jq
    lua
    luarocks
    mpv
    nodejs_22
    podman
    obsidian
    docker
    telegram-desktop
    tesseract
    sqlitebrowser
    xfce.thunar
    xfce.thunar-volman
    vlc
    acpi
    zoxide
    pamixer
    wlsunset
    fuzzel
    progress
    swappy
    atac
    tokei
    grim
    slurp
    python3Full
    libgcc
    gcc
    eza
    libreoffice
    libnotify
    pyprland
    libinput-gestures
    blueman
    swaybg
    hypridle
    wl-clipboard
    tealdeer
    ollama
    gnome-tweaks
    home-manager
    gparted
    kdePackages.partitionmanager
    python312Packages.pillow
    python312Packages.tkinter
    tk
    eog
    nh
    gnomeExtensions.nordvpn-quick-toggle
    figlet
    lolcat
    entr
    diff-so-fancy
    libsForQt5.qtstyleplugin-kvantum
    libsForQt5.qt5ct
    wayland-scanner.dev
    dig
    chromium
    glib

  ];

  fonts = {
    fontDir.enable = true;
    packages = with pkgs; [
      jetbrains-mono
      nerd-font-patcher
      (
        nerdfonts.override {
          fonts = [ "FiraCode" "DroidSansMono" "Hack" "UbuntuMono" "NerdFontsSymbolsOnly" ];
        })
    ];
  };

  services.mysql = {
    enable = true;
    package = pkgs.mysql;
  };
  users.extraGroups.vboxusers.members = [ "sanbid" ];

  services = {
    ollama.enable = true;
  };

  # Allow unfree packages
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  system.stateVersion = "24.05"; # Did you read the comment?
}
